Rails.application.routes.draw do
  
  get '/' => 'home#top'
  get 'home/about' => 'home#about'
  root 'home#top'

  devise_for :users

  resources :users,only: [:show,:index,:edit,:update]
  resources :books
end