Rails.application.routes.draw do
  devise_for :users

  namespace :management do
    get '/', to: 'conferences#index'

    resources :conferences do
      resources :events
      resources :volunteers
      resources :sponsorship_offers
      resource :call_for_participation, only: [:create, :destroy]
    end
    resources :users do
      member do
        put :toggle_admin
      end
    end
  end

  root 'management/conferences#index'
end
