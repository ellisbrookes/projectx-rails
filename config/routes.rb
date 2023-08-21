Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: 'registrations/registrations' }

  root 'pages#home'

  resources :teams

  patch '/update_dark_mode_preference', to: 'darkmode#update_dark_mode_preference'

  resources :dashboard, only: [:index] do
    collection do
      # add companies resources
      resources :companies
    end
  end
end
