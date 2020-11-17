class Api::UsersController < ApplicationController 
    skip_before_action :authorise, except: [:get_user,:update]
    def create 
        @current_user = User.new(user_params)
        if current_user.save!
            @token = encode_to_jwt({user_id: current_user.id})
            render 'show'
        end       
    rescue Exception=>e
        first_error_key = current_user.errors.messages.keys.first
        render json: {error:true,keys:current_user.errors.messages.keys,  msg:"#{first_error_key.to_s} #{current_user.errors.messages[first_error_key].first}"}
    end
    def get_user
        # render json: {error:false,  user: current_user.get_visible_attr}
        render 'show'
        
    end
    def login 
        @current_user = User.find_by(email: user_params['email'])
        if current_user.nil?
            raise Exception.new("User does not exist")
        end
        if current_user.valid_password?(user_params['password'])
            @token = encode_to_jwt({user_id: current_user.id})
            
            render 'show'
            return
        end
        raise Exception.new("Email and password does not match")
    rescue Exception=>e

        render json: {error:true,  msg:e.message}
    end

    def update
        if current_user.update!(user_params)
            render 'show'
        end 
    rescue Exception=>e

        render json: {error:true,  msg:e.message}
    end

    def user_params
        params.require(:user).permit(:first_name,:last_name,:image, :city, :password, :phone, :email,:player_of,:about,:featured,:isVendor)
    end
end
