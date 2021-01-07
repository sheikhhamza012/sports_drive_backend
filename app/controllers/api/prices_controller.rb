class Api::PricesController < ApplicationController 
    before_action :set_group, only: [:create,:show,:update]
    before_action :set_field, only: [:index,:create]
    def create
        price = Price.new(price_params)
        if params[:field_id].nil?
            price.priceable = @group
            price.save!
            render 'create'
        else
            price.priceable = @field
            price.save!
            render json:{error:false, price:price.attributes.slice('id', 'from_time', 'date', 'to_time', 'name', 'price_type','price')}
        end
    rescue Exception => e
        msg = e.message
        render json: {error:true, msg: msg}
    end
    def show
        render 'show'
    end
    def index
        @prices = @field.prices.where(date:Date.parse(params[:date]).all_day)
    end
    def update
        price = Price.find(params[:id])
        price.update!(price_params) 
        render 'create'
    rescue Exception => e
        msg = e.message
        render json: {error:true, msg: msg}
    end
    
    def destroy
        price = Price.find(params[:id])
        if price.delete
            render json:{error:false}
            return
        end
        render json:{error:true,msg:"Something went wrong"}
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
    def set_field
        if !params[:field_id].nil?
            @field = Field.find(params[:field_id])
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
        params.require(:price).permit(:from_time,:to_time,:price,:name,:price_type,:date)
    end
end
