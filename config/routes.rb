require 'sidekiq/web'

Rails.application.routes.draw do
  root 'users/posts#index'
  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks' },
             skip: %i[password]

  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end

  resources :posts, only: %i[index new create] do
    member do
      get 'publish'
      post 'authenticate'
    end
  end

  namespace :users do
    resources :posts, only: %i[show]
  end

  resources :tokens, only: :create

  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
end
