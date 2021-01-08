class Api::DevicesController < ApplicationController 
    skip_before_action :authorise, only: [:destroy]
    before_action :set_user, only:[:destroy]
    def create
        existing = Device.find_by(fcm_token:params[:token])
        if existing.present?
            existing.update(user:current_user)
            render json: {error:false, msg:"Token Saved"}
            return
        end
        current_user.devices.create!(fcm_token:params[:token])
        render json: {error:false, msg:"Token Saved"}
    rescue Exception=>e
        render json: {error:true,msg:e.message}
    end

    def destroy
        device = @user.devices.find_by(fcm_token:params[:id])
        if device 
            if device.delete
                render json: {error:false, msg:"Token deleted"}
            else
                render json: {error:false, msg:"Could not delete token"}
            end
        else
            render json: {error:false, msg:"Could not find device"}
        end
    rescue Exception=>e
        render json: {error:true,msg:e.message}
    end

    private 
    def set_user
        if params[:user_id].present?
            @user = User.find_by(id:params[:user_id])
        end
    end
end
