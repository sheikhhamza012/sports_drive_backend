class Api::PricesController < ApplicationController 
    before_action :set_group, except: []
    def create
        price = Price.new(price_params)
        price.priceable = @group
        price.save!
    rescue Exception => e
        msg = e.message
        render json: {error:true, msg: msg}
    end
    def show
        render 'show'
    end
    def update
        price = Price.find(params[:id])
        price.update!(price_params) 
        render 'create'
    rescue Exception => e
        msg = e.message
        render json: {error:true, msg: msg}
    end
    
    private

    def set_group
        if !params[:group_id].nil?
            @group = Group.find(params[:group_id])
            authorize @group, :update?
        end
    rescue Exception => e
        msg = "Error occured, Try again later"
        if e.class == Pundit::NotAuthorizedError
            msg = "You are not allowed this action"
        end
        puts e
        render json: {error:true, msg: msg}
    end


    def price_params
        params.require(:price).permit(:from_time,:to_time,:price,:name,:price_type)
    end
end
