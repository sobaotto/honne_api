Rails.application.routes.draw do
  root to: 'questions#index'

  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only: [:create]
  resources :questions, only: [:index, :show, :create]
  resources :answers, only: [:create]
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
