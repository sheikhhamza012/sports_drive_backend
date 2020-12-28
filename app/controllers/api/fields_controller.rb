class Api::FieldsController < ApplicationController 
    before_action :set_field, except: [:create,:search,:search_by_availability]
    def create 

    end
    def show
        render 'show'
    end
    def update
        
    end
    
    def book_arena
        booking = current_user.arena_booking_requests.new(arena_booking_request_params)
        booking.field = @field
        if booking.save!
            @request = booking
            render 'api/arena_booking_request/show'
        end
    rescue Exception => e
        puts "----------------->"
        puts e
        render json:{error:true, msg:booking.errors.first.last}
    end


    private

    def set_field
        if params[:id].present?
            @field = Field.find(params[:id])
            authorize @field
        end
    rescue Exception => e
        msg = "Error occured, Try again later"
        if e.class == Pundit::NotAuthorizedError
            msg = "You are not allowed this action"
        end
        puts e
        render json: {error:true, msg: msg}
    end


    def arena_booking_request_params
        params.require(:arena_booking_request).permit(:from_time,:to_time)
    end
end
