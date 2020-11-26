class Api::ArenaController < ApplicationController 
    before_action :set_arena, except: [:create,:search,:search_by_availability]
    def create 

    end
    def show
        render 'show'
    end
    def update
        
    end
    def search
        @arenas = Arena.where("name ILIKE ? or location ILIKE ?","%#{params[:keyword]}%","%#{params[:keyword]}%")
        render 'index'
    end
    def search_by_availability
        @arenas = Arena.get_available_arenas(params[:location],params[:from_time],params[:to_time])
        render 'index'
    
    rescue Exception=>e
        
        render json:{error:true, msg:e.message}

    end
    def book_arena
        booking = current_user.arena_booking_requests.new(arena_booking_request_params)
        booking.arena = @arena
        if booking.save!
            
            render json:{error:false, msg:"The booking request is sent to owner"}
        end
    rescue Exception => e
        render json:{error:true, msg:booking.errors.first.last}
    end

    private

    def set_arena
        @arena = Arena.find(params[:id])
        authorize @arena
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
