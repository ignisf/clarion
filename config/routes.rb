Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registrations', confirmations: 'confirmations'}

  scope module: :public do
    root to: 'home#index'
    resource :personal_profile, path: 'profile'
    resources :events
  end

  namespace :management do
    root to: 'home#index'

    resources :conferences do
      resources :events
      resources :volunteers
      resources :propositions
      resources :sponsorship_offers
      resource :call_for_participation, only: [:create, :destroy]

      resources :personal_profiles do
        member do
          put :toggle_admin
        end
      end
    end
  end
end
