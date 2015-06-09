Rails.application.routes.draw do
  devise_for :users

  namespace :management do
    root to: 'home#index'

    put '/set_conference/:id', to: 'home#set_conference', as: :set_conference

    resources :conferences

    scope ':current_conference' do
      resources :events
      resources :volunteers
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
