Rails.application.routes.draw do
  devise_for :users  
  namespace :api, defaults: { format: :json } do
    
    resources :tests 
    resources :arena do
      member do
        post :book_arena
      end
      collection do
        post :search
      end
    end
    resources :users do 
      collection do
        post :login
        get :get_user
        patch '', to: 'users#update'
      end
    end
  end  
end
