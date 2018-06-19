Rails.application.routes.draw do
  get '/contact', to: "pages#contact"
  get '/about', to: "pages#about"
  root "pages#index"
  resources :users
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
