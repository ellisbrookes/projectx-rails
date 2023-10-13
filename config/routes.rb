Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: 'registrations/registrations' }

  root 'pages#home'

  resources :teams

  resources :projects

  resources :tasks do
    resources :comments, only: [:create, :destroy]
  end

  resources :sub_tasks

  resources :dashboard, only: [:index] do
    collection do
      # add companies resources
      resources :companies
    end
  end
end
