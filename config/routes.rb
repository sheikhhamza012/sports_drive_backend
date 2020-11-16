Rails.application.routes.draw do
  devise_for :users  
  namespace :api, defaults: { format: :json } do
    
    resources :tests 
    resources :users do 
      collection do
        post :login
        get :get_user
      end
    end
  end  
end
