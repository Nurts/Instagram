Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :create]
    end
  end
  get 'relationships/create'
  get 'relationships/destroy'
  get 'password_resets/new'
  get 'password_resets/edit'
  get '/contact', to: "pages#contact"
  get '/about', to: "pages#about"
  root "pages#index"
  resources :users
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :account_activations, only: [:edit]
  resources :posts, only: [:create, :destroy]
  #resources :likes, only: [:create]
  post "/like", to: "likes#create"
  delete "/unlike", to: "likes#destroy"
  resources :password_resets, only: [:new, :create, :edit, :update]
  post "/follow", to: "relationships#create"
  delete "/unfollow", to: "relationships#destroy"
end
