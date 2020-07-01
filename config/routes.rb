Rails.application.routes.draw do
  get 'samples/index'
  devise_for :users
  root 'home#top'
  get 'home/about'
  resources :books do
  	resource :favorites, only: [:create, :destroy]
  	resource :book_comments, only: [:create, :destroy]
end

  resources :users,only: [:show,:index,:edit,:update]
  resources :maps, only: [:index]
  	get '/map_request', to: 'maps#map', as: 'map_request'
end
