Rails.application.routes.draw do
  mount OpenFest::Engine, at: '/', constraints: {subdomain: 'cfp'}, conference_id: 1

  devise_for :users, path: 'management'

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
