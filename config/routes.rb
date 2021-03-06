require 'sidekiq/web'

Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users,
             controllers: { omniauth_callbacks: 'omniauth_callbacks' },
             skip: %i[password]

  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end

  resources :posts, only: %i[show]

  namespace :user do
    resources :posts, only: %i[index new create show]

    resources :otps, only: :show do
      member do
        post 'send_otp'
        post 'verify'
      end
    end
  end



  mount Sidekiq::Web => '/sidekiq'
end
