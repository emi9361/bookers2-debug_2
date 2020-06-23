Rails.application.routes.draw do
  devise_for :users
  resources :books do
  	resource :favorites, only: [:create, :destroy]
  	resource :book_comments, only: [:create, :destroy]
end

  resources :users,only: [:show,:index,:edit,:update,] do
  		member do
  		get :following, :followers
  	  end
    end
    resources :relationships, only:[:create, :destroy]
    get 'search/search'
    root 'home#top'
    get 'home/about'
    get '/search' => 'search#search'
end
