Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # devise_for :user 
  
  get 'friends', to: 'friends#index'
  get 'users/search', to: 'users#search'
  delete 'friends/destroy'

  resources :friend_requests, except: [:show, :edit, :new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  root to: 'home#index'
  # get 'home/index'
  get 'articles/new', to: 'articles#new'
  get 'articles', to: 'articles#index'
  post 'articles', to: 'articles#create'
  get 'articles/:id', to: 'articles#show', as: 'article'
  patch 'articles/:id', to: 'articles#update'
  delete 'articles/:id', to: 'articles#destroy'
  get 'articles/:id/edit', to: 'articles#edit', as: 'article_edit'

  resources :users, except: [:index] do 
    member do
      get :confirm_email
      get :change_password
      patch :change_password_confirm
    end
  end

  post 'comments/:id/edit', to: 'comments#create'
  get 'comments/:id/edit', to: 'comments#edit', as: 'comment_edit'
  patch 'comments/:id/edit', to: 'comments#update'
  delete 'comments/:id/edit', to: 'comments#destroy'

  resources :groups do 
    resources :group_articles, :path => "articles", :as => "articles"
  end

  resources :group_comments, only: [:create, :edit, :update, :destroy]

  delete 'groups/:id/leave', to: 'groups#leave_group', as: 'leave_group'

end
