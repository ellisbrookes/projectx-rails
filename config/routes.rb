Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users, controllers: { registrations: 'registrations/registrations' }

  root 'pages#home'

  resources :dashboard, only: [:index] do
    collection do
      resources :companies
      resources :teams
      resources :projects
      resources :sub_tasks
      resources :tasks do
        resources :comments, only: [:create, :destroy]
      end
    end
  end
end
