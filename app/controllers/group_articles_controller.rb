class GroupArticlesController < ApplicationController
    before_action :set_group#, only: [:index, :new, :create, :show]
    before_action :set_group_article, only: [:show, :edit, :update, :destroy]
    before_action :authorize_group_article, only: [:new, :create]
    # after_action :verify_authorized

    def index
        @articles = @group.group_articles
    end

    def show
        @user = User.find_by_id(@article.user_id)
        @comment = GroupComment.new
        @comments = GroupComment.where(group_article_id: @article.id).includes(:user, :group_article)
    end

    def new
        @article = GroupArticle.new
    end

    def create
        @article = GroupArticle.new(group_article_params)
        @article.user = current_user
        @article.group = @group
        if @article.save
            redirect_to group_article_path(@group, @article), 
            flash: {success: "#{@group.item_name} was created."}
        else
            render 'new'
        end
        
    end

    def edit
    end

    def update
        if @article.update(group_article_params)
            redirect_to group_article_path(@group, @article),
            flash: {success: "#{@article.group.item_name} was updated."}
        else
            render 'edit'
        end
    end

    def destroy
        if @article
            @article.destroy
            redirect_to group_path(@group), flash: {success: "#{@group.item_name} was deleted."}
        else
            render 'show'
        end
    end

private

    def group_article_params
        params.require(:group_article).permit(:title, :content)
    end

    def set_group
        @group = Group.find_by_id(params[:group_id])
        authorize @group, :show_group?
    end

    def set_group_article
        @article = GroupArticle.find_by_id(params[:id])
        authorize @article
    end    

    def authorize_group_article
        authorize GroupArticle
    end

end
