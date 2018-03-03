Rails.application.routes.draw do
  use_doorkeeper

  resources :users, only: [:new, :create]

  namespace :api do
    namespace :v1 do
      namespace :credentials do
        get :me
      end
    end
  end

  root to: 'users#new'
end
