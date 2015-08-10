OpenFest::Engine.routes.draw do
  root to: 'events#index'

  devise_for :users, module: 'open_fest/users'

  resource :personal_profile, path: 'profile'
  resources :events
end
