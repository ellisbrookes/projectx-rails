Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users, controllers: { registrations: 'registrations/registrations' }

  root 'pages#home'

  resources :dashboard, only: [:index] do
    collection do
      resources :companies do
        resources :teams do
          resources :projects do
            resources :tasks do
              resources :sub_tasks
              resources :comments, only: [:new, :create, :edit, :update, :destroy]
            end
          end
        end
      end
    end
  end
end
