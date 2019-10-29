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
  

  get 'users/new', to: 'users#new'
  post 'users/new', to: 'users#create'
  get 'users/:id/edit', to: 'users#edit', as: 'user_edit'
  patch 'users/:id/edit', to: 'users#update'
  delete 'users/destroy', to: 'users#destroy'
  get 'users/:id', to: 'users#show', as: 'user'

  post 'comments/:id/edit', to: 'comments#create'
  get 'comments/:id/edit', to: 'comments#edit', as: 'comment_edit'
  patch 'comments/:id/edit', to: 'comments#update'
  delete 'comments/:id/edit', to: 'comments#destroy'

  get 'groups', to: 'groups#index'
  get 'groups/new', to: 'groups#new'
  post 'groups', to: 'groups#create'
  get 'groups/:name/edit', to: 'groups#edit', as: 'group_edit'
  patch 'groups/:name/edit', to: 'groups#update'
  # patch 'groups/edit', to: 'groups#update'
  get 'groups/:name', to: 'groups#show', as: 'group_articles'
  
  post 'groups/:name', to: 'group_articles#create'
  get 'groups/:name/new', to: 'group_articles#new', as: 'group_articles_new'
  get 'groups/:name/:title', to: 'group_articles#show', as: 'group_article'
  patch 'groups/:name/:title', to: 'group_articles#update'
  delete 'groups/:name/:title', to: 'group_articles#destroy'
  
  # post 'groupcomments/:name/:title/comments', to: 'group_comments#create', as: 'group_comments'
  post 'groups/:name/:title/comments', to: 'group_comments#create', as: 'group_comments'
  patch 'groups/:name/:title/comments', to: 'group_comments#update'
  get 'groups/:name/:title/comments/edit', to: 'group_comments#edit', as: 'groupcomment_edit'
  # patch 'groups/:name/:title/comments/edit', to: 'group_comments#update'
  delete 'groups/:name/:title/comments/edit', to: 'group_comments#destroy'

  get 'groups/:name/:title/edit', to: 'group_articles#edit', as: 'group_article_edit'
  # patch 'groups/:name/:title/edit', to: 'group_articles#update'
  # delete 'groups/:name/:title/edit', to: 'group_articles#destroy'


  # resources :groups do
  #   resources :group_articles
  # end

  # resources :articles do
  #   resources :comments, shallow: true
  # end

end
