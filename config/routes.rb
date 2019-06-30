Rails.application.routes.draw do
  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks' },
             skip: %i[password registrations]

  devise_scope :user do
    resource :registration,
             only: %i[new create],
             path: 'users',
             path_names: { new: 'sign_up' },
             controller: 'devise/registrations'

    get '/users', to: 'devise/registrations#new'
  end
  root 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
