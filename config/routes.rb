Rails.application.routes.draw do
  resources :follows
  resources :posts
  resources :users

  root 'sessions#index'
  post '/login' => 'sessions#create'
  post '/signup' => 'users#create'
  get '/timeline' => 'posts#timeline'
  post '/follow/:id' => 'users#follow'
  post '/unfollow/:id' => 'users#unfollow'
  # get '/users/search' => 'users#search'
  # get '/posts/search' => 'posts#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
