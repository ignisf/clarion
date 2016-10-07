Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registrations', confirmations: 'confirmations'}

  scope module: :public do
    root to: 'home#index'
    resource :personal_profile, path: 'profile'
    resources :events do
      member do
        get :confirm
      end
    end
    resources :volunteers
    resources :volunteer_teams, only: [:index]
  end

  namespace :api do
    resources :conferences, only: [] do
      resources :events, only: :index do
        collection do
          get :halfnarp_friendly
        end
      end
      resources :speakers, only: :index
      resources :tracks, only: :index
      resources :event_types, only: :index
      resources :halls, only: :index
      resources :slots, only: :index
    end
  end

  namespace :management do
    root to: 'conferences#index'

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
