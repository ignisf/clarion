OpenFest::Engine.routes.draw do
  root to: 'events#index'

  scope '(/:locale)' do
    devise_for :users, module: 'open_fest/users'

    resource :personal_profile, path: 'profile'
    resources :events
  end
end
