class Api::ArenaBookingRequestController < ApplicationController 
    def index
        @requests = current_user.arena_booking_requests
    rescue Exception=>e
        render json:{error: true, msg: e.message}
    end
    def get_active_request
        @request = current_user.arena_booking_requests.where('from_time >= ? or to_time > ?', Time.now, Time.now).order(:from_time).first
        render 'show'
    rescue Exception=>e
        render json:{error: true, msg: e.message}
    end
end
