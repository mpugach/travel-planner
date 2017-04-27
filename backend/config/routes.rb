Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'

      resources :trips, only: %i[create show index update destroy]
      resources :users, only: %i[create show index update destroy]
    end
  end
end
