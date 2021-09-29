Rails.application.routes.draw do
  resources :entries
  root to: "shared#home"
end
