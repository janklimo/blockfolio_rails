Rails.application.routes.draw do
  use_doorkeeper

  resources :users, only: [:new, :create]

  root to: 'users#new'
end
