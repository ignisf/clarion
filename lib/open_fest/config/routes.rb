OpenFest::Engine.routes.draw do
  get 'welcome/index'

  root to: 'welcome#index'

  devise_for :users, module: 'open_fest/users'
end
