Rails.application.routes.draw do
  devise_for :users  
  namespace :api, defaults: { format: :json } do
    resources :teams do
      collection do
        get :join
        get :get_allowed_individual_joining
      end
    end
    resources :prices, only: [:destroy]
    resources :devices, only: [:create]
    resources :fields do
      resources :arena_booking_request, only: [:index]
      resources :prices, only: [:index,:create]
      member do
        post :book_arena
      end
    end
    resources :groups do
      resources :prices
    end
    resources :arena_booking_request do
      collection do
        get :pending_requests
        get :send_notif
        get :get_active_request
        get :my_orders
        get :my_earning
      end
      member do
        get :order_detail
      end
    end
    resources :arena do
      collection do
        post :search
        post :search_by_availability
        get :my_arenas
      end
      member do
        post :availibility
      end
    end
    resources :users do 
      resources :devices, only: [:destroy]
      collection do
        post :login
        post :become_a_vendor
        get :get_user
        patch '', to: 'users#update'
      end
      
    end
  end  
end
