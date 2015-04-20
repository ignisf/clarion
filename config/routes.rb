Rails.application.routes.draw do
  devise_for :users

  namespace :management do
    get '/', to: 'conferences#index'

    resources :conferences do
      member do
        post 'cfp', to: 'conferences#open_call_for_papers'
        delete 'cfp', to: 'conferences#close_call_for_papers'
      end

      resources :events do
        member do
          patch 'state'
        end

        collection do
          get 'approved'
          get 'rejected'
          get 'undecided'
          get 'backup'
          get 'confirmed'
        end
      end
    end

    resources :users do
      member do
        post 'toggle_admin'
      end
    end
  end

  root 'management/conferences#index'
end
