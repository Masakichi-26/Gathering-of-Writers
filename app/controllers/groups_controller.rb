class GroupsController < ApplicationController
    before_action :set_group, only: [:show, :edit, :update, :destroy, :leave_group]
    before_action :authorize_group, only: [:new, :create, :index]

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

        max_group_size = 5
        @group.users << current_user
        if params[:friends] != nil
            if params[:friends].length > max_group_size
                @friends = current_user.friends
                flash.now[:error] = "You can only add up to 5 friends in a group."
                render 'new'
                return
            end

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
        # byebug
    end

    def show
        # byebug
        # @group = Group.find_by(name: params[:name])
        @articles = @group.group_articles.includes(:user)
    end

    def edit
        if logged_in?
            @friends = current_user.friends
        end
    end

    def update
        max_group_size = 5

        @users_to_remove = []
        @users_to_add = []

        if params[:friends] == nil
            @group.users.each do |u|
                if u != current_user
                    @users_to_remove << u
                end
            end
        else
            if params[:friends].length > max_group_size
                @friends = current_user.friends
                redirect_to edit_group_path(@group), flash: {error: "You can only add up to 5 friends in a group."}
                return
            end

            @group.users.each do |u|
                if !params[:friends].include?(u.username) && u != current_user
                    @users_to_remove << u
                end
            end

            params[:friends].each do |f|
                if !@group.users.find_by(username: f)
                    @users_to_add << User.find_by(username: f)
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

            redirect_to group_path(@group), flash: {success: "Group was updated."}

        else
            @friends = current_user.friends
            render 'edit'
        end
    end

    def destroy
        if @group
            @group.destroy
            redirect_to groups_path, flash: {success: "Group was deleted."}
        else
            render 'index'
        end
    end

    def leave_group
        @group.users.destroy(current_user)
        redirect_to groups_path, flash: {success: "You have been removed from the group."}
    end

private

    def group_params
        params.require(:group).permit(:name, :description, :item_name, :user_id, :creator)
    end

    def set_group
        @group = Group.find(params[:id])
        authorize @group
    end

    def authorize_group
        authorize Group
    end

end
