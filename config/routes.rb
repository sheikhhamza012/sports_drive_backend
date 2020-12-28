Rails.application.routes.draw do
  devise_for :users  
  namespace :api, defaults: { format: :json } do
    
    resources :fields do
      member do
        post :book_arena
      end
    end
    resources :groups do
      resources :prices
    end
    resources :arena_booking_request do
      collection do
        get :get_active_request
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
      collection do
        post :login
        post :become_a_vendor
        get :get_user
        patch '', to: 'users#update'
      end
      
    end
  end  
end
