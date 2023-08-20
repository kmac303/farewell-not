Rails.application.routes.draw do
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  post "/signup", to: "users#create"
  get "/me", to: "users#show"

  post '/start_scraper', to: 'scraper#start'
  
  resources :matches, only: [:index, :show, :create, :update, :destroy]
  resources :recipients, only: [:index, :show, :create, :update]
  resources :messages
  resources :users, only: [:show, :create]

  # Leave this here to help deploy your app later!
  get "*path", to: "fallback#index", constraints: ->(req) { !req.xhr? && req.format.html? }
end

