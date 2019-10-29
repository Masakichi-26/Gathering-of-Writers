class GroupCommentsController < ApplicationController
    before_action :set_group_comment, only: [:edit, :update, :destroy]

    def create
        @comment = GroupComment.new(group_comment_params)
        @comment.group_article_id = params[:group_article_id]
        @comment.user_id = current_user.id

        # byebug
        if @comment.save
            redirect_to group_article_path(@comment.group_article.group.name, @comment.group_article.title),
            flash: {success: 'Comment was created.'}
        else
            @article = GroupArticle.find(params[:group_article_id])
            redirect_to group_article_path(@article)
        end
    end

    def edit 
        @article = GroupArticle.find(@comment.group_article_id)
    end

    def update
        @article = GroupArticle.find(@comment.group_article_id)
        if @comment.update(group_comment_params)
            redirect_to group_article_path(@comment.group_article_id), flash: {success: 'Comment was updated.'}
        else
            render action: 'edit'
        end
    end

    def destroy
        @article = @comment.group_article
        if @comment
            @comment.destroy
            redirect_to group_article_path(@article.group.name, @article.title), flash: {success: "Comment was deleted."}
        else
            render 'grouparticles/show'
        end
    end

private

    def group_comment_params
        params.require(:group_comment).permit(:content, :group_article_id, :user_id)
    end

    def set_group_comment
        @comment = GroupComment.find(params[:group_comment_id])
        # authorize @comment
    end

end