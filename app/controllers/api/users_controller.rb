class Api::UsersController < ApplicationController 
    skip_before_action :authorise
    def create 
        user = User.new(user_params)
        if user.save!
            token = encode_to_jwt({user_id: user.id})
            render json: {error:false,  auth_token:token}
        end       
    rescue Exception=>e
        first_error_key = user.errors.messages.keys.first
        render json: {error:true,keys:user.errors.messages.keys,  msg:"#{first_error_key.to_s} #{user.errors.messages[first_error_key].first}"}
    end

    def login 
        user = User.find_by(email: user_params['email'])
        if user.nil?
            raise Exception.new("User does not exist")
        end
        if user.valid_password?(user_params['password'])
            token = encode_to_jwt({user_id: user.id})
            render json: {error:false,  auth_token:token}
            return
        end
        raise Exception.new("Email and password does not match")
    rescue Exception=>e

        render json: {error:true,  msg:e.message}
    end


    def user_params
        params.require(:user).permit(:first_name,:last_name, :city, :password, :phone, :email)
    end
end
