class GroupsController < ApplicationController
    before_action :authorize_group, except: [:show, :edit, :update]

    def new
        @group = Group.new
        if logged_in?
            @friends = current_user.friends
        end
    end

    def create
        @group = Group.new(group_params) 
        @group.user_id = session[:user_id]
        @group.creator = current_user
        if @group.item_name.strip == ""
            @group.item_name = "Article"
        end

        @group.users << current_user
        if params[:friends] != nil
            params[:friends].each do |f| 
                @group.users << User.find_by(username: f)
            end
        end

        if @group.save
            redirect_to groups_path(@group), flash: {success: "Group was created."}
        else
            @friends = current_user.friends
            render 'new'
        end
    end

    def index
        @groups = current_user.groups.includes(:creator)
        authorize @groups
    end

    def show
        # byebug
        # @group = Group.find_by(name: params[:name])
        @group = Group.find(params[:group_id])
        authorize @group
        @articles = @group.group_articles.includes(:user)
    end

    def edit
        @group = Group.find(params[:group_id])
        authorize @group
        if logged_in?
            @friends = current_user.friends
        end
    end

    def update
        @group = Group.find_by(id: params[:group_id])
        authorize @group

        @users_to_remove = []
        @users_to_add = []

        if params[:friends] == nil
            @group.users.each do |u|
                if u != current_user
                    @users_to_remove << u
                end
            end
        else
            @group.users.each do |u|
                if !params[:friends].include?(u.username) && u != current_user
                    @users_to_remove << u
                    # @group.users.delete(u)
                end
            end

            params[:friends].each do |f|
                if !@group.users.find_by(username: f)
                    @users_to_add << User.find_by(username: f)
                    # @group.users << User.find_by(username: f)
                end
            end
        end

        

        if @group.update(group_params)
            if @users_to_remove
                @group.users.delete(@users_to_remove)
            end

            if @users_to_add
                @users_to_add.each do |u|
                    @group.users << u
                end
            end

            redirect_to group_articles_path(@group.name, group_id: @group.id), flash: {success: "Group was updated."}

        else
            @friends = current_user.friends
            render 'edit'
        end
    end

private

    def group_params
        params.require(:group).permit(:name, :description, :item_name, :user_id, :creator)
    end

    def authorize_group
        authorize Group
    end

end
