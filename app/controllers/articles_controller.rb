class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :authorize_article, only: [:new, :create]
    after_action :verify_authorized, except: [:index]

    def index
        @articles = Article.all.includes(:user)
    end

    def show
        @user = User.find_by(id: @article.user_id)
        @comment = Comment.new
        @comments = Comment.where(article_id: params[:id]).includes(:user)
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        @article.user_id = session[:user_id]
        if @article.save
            redirect_to @article, flash: {success: "Article was created."}
        else
            render 'new'
        end
        
    end

    def edit
    end

    def update
        if @article.update(article_params)
            redirect_to article_path(@article.id)
        else
            render 'edit'
        end
    end

    def destroy
        if @article
            @article.destroy
            redirect_to articles_path, flash: {success: "Article was deleted."}
        else
            render 'show'
        end
    end

private

    def article_params
        params.require(:article).permit(:title, :content)
    end

    def set_article
        @article = Article.find(params[:id])
        authorize @article
    end

    def authorize_article
        authorize Article
    end

end
