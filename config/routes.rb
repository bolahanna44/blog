require 'sidekiq/web'

Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks' },
             skip: %i[password]

  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end

  resources :posts, only: %i[new show create update] do
    member do
      get 'publish'
    end
  end

  post 'verify_token', to: 'tokens#verify'
  post 'send_token', to: 'tokens#send_token'

  mount Sidekiq::Web => '/sidekiq'
end
