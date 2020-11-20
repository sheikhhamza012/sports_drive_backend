class Api::ArenaBookingRequestController < ApplicationController 
    def index
        @requests = current_user.arena_booking_requests

    end
end
