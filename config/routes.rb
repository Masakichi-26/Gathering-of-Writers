Rails.application.routes.draw do
  get 'friends/index'
  get 'users/search', to: 'users#search'
  delete 'friends/destroy'

  resources :friend_requests
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
  

  # get 'users/new', to: 'users#new'
  # post 'users/new', to: 'users#create'
  # get 'users/:id/edit', to: 'users#edit', as: 'user_edit'
  # patch 'users/:id/edit', to: 'users#update'
  # delete 'users/destroy', to: 'users#destroy'
  # get 'users/:id', to: 'users#show', as: 'user'

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
