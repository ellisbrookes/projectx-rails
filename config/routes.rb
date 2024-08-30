Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users, controllers: { sessions: 'users/sessions' }

  root 'pages#home'

  # Stripe checkouts
  get 'pricing', to: 'stripe/pricing#index'
  post 'stripe/checkout', to: 'stripe/checkout#checkout'
  post 'stripe/checkout/success', to: 'stripe/checkout#success'
  post 'stripe/checkout/cancel', to: 'stripe/checkout#cancel'
  # stripe listen --forward-to localhost:3000/stripe/webhooks
  post 'stipe/webhooks', to: 'stripe/webhooks#create'

  resources :dashboard, only: [:index] do
    collection do
      resources :notifications, only: %i[index] do
        collection do
          post 'mark_as_read', to: 'notifications#mark_as_read', as: 'mark_as_read'
          post 'mark_as_unread', to: 'notifications#mark_as_unread', as: 'mark_as_unread'
        end
      end

      resources :companies do
        resources :customers do
          member do
            get 'load_data', to: 'customers#load_data', as: 'load_data'
          end
        end

        resources :items do
          member do
            get 'load_data', to: 'items#load_data', as: 'load_data'
          end
        end

        resources :invoices, except: %i[destroy]
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
