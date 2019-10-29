class CommentsController < ApplicationController
    before_action :set_comment, only: [:edit, :update, :destroy]
    before_action :authorize_comment, only: [:create]
    after_action :verify_authorized

    def create
        @comment = Comment.new(comment_params)
        @comment.article_id = params[:id]
        @comment.user_id = session[:user_id]
        if @comment.save
            redirect_to article_path(params[:id]), flash: {success: 'Comment was created.'}
        else
            @article = Article.find(params[:id])
            redirect_to article_path(@article)
            # redirect_back(fallback_location: root_path)
        end
    end

    def edit
        @article = Article.find(@comment.article_id)
        # redirect_to article_path(@comment.article_id)
    end

    def update
        @article = Article.find(@comment.article_id)
        if @comment.update(comment_params)
            redirect_to article_path(@comment.article_id), flash: {success: 'Comment was updated.'}
        else
            render action: 'edit'
        end
    end

    def destroy
        @article = @comment.article
        if @comment
            @comment.destroy
            redirect_to article_path(@article), flash: {success: "Comment was deleted."}
        else
            render 'articles/show'
        end
    end

private

    def comment_params
        params.require(:comment).permit(:content, :article_id, :user_id)
    end

    def set_comment
        @comment = Comment.find(params[:id])
        authorize @comment
    end

    def authorize_comment
        authorize Comment
    end

end