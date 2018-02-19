Rails.application.routes.draw do
  use_doorkeeper

  resources :users, only: [:new, :create]

  namespace :api do
    namespace :v1 do
      resources :credentials do
        collection do
          get :me
        end
      end
    end
  end

  root to: 'users#new'
end
