Rails.application.routes.draw do
  resources :todos
  get 'archives/index'
  resources :entries
  root to: "shared#home"
end
