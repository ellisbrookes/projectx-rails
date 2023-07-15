Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: 'registrations/registrations' }

  root 'pages#home'

  resources :dashboard, only: [:index] do
    collection do
      # add companies resources and set compnay as path and uri
      # prefix   URI    controller
      # as       path   companies 
      resources :companies, path: 'company', as: 'company', controller: :companies
    end
  end
end
