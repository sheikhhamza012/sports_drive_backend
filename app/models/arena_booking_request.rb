class ArenaBookingRequest < ApplicationRecord
    enum status: [:pending,:accepted,:declined]
    belongs_to :user
    belongs_to :arena
    validates :from_time, presence: true
    validates :to_time, presence: true
    validate :booking_available, :times_are_valid

    def booking_available
        records_in_time = arena.arena_booking_requests.where(from_time: from_time..to_time, status:"accepted").or(arena.arena_booking_requests.where(to_time: from_time..to_time,status:"accepted"))
        if records_in_time.size>0
            errors.add(:from_time, "the Arena is not available for this duration")
        end
    end
    def times_are_valid
        if from_time>=to_time
            errors.add(:from_time, "From Time cant be same as or after To Time")
            errors.add(:to_time, "To Time cant be same as or before From Time")
        end
    end

end
