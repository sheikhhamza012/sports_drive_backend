class  Api::TestsController < ApplicationController 
    def index 
        render json:{user: current_user.id}      
    end
   
end
