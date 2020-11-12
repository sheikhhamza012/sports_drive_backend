Rails.application.routes.draw do
  devise_for :users  
  namespace :api, defaults: { format: :json } do
    
    resources :tests 
    resources :users do 
      collection do
        post :login
      end
    end
  end  
end
