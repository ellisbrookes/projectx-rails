Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
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
