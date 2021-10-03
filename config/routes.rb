Rails.application.routes.draw do
  devise_for :users
  resources :todos
  get 'archives/index'
  resources :entries
  root to: "shared#home"
end
