Rails.application.routes.draw do
  get '/contact', to: "pages#contact"
  get '/about', to: "pages#about"
  root "pages#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
