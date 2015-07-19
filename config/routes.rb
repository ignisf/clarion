Rails.application.routes.draw do
  devise_for :users

  namespace :management do
    root to: 'home#index'

    resources :conferences do
      resources :events
      resources :volunteers
      resources :propositions
      resources :sponsorship_offers
      resource :call_for_participation, only: [:create, :destroy]

      resources :users do
        member do
          put :toggle_admin
        end
      end
    end
  end
end
