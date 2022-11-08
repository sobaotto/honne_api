# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  defaults format: :json do
    root to: 'questions#index'

    get '/me', to: 'sessions#show'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'

    resources :users, only: %i[index create]
    resources :questions, only: %i[index show create destroy]
    resources :answers, only: %i[index create]
  end
end
