Rails.application.routes.draw do
  get 'archives/index'

  resources :entries
  root to: "shared#home"
end
