class ArenaBookingRequest < ApplicationRecord
    enum status: ["Pending","Accepted","Declined","Blocked"]
    belongs_to :user
    belongs_to :field
    validates :from_time, presence: true
    validates :to_time, presence: true
    validate :booking_available, :times_are_valid, :on => :create
    after_create do
        NotificationHelper.send(
            field.group.arena.user.devices.pluck(:fcm_token),
            { title: "Booking Request Recieved", body:"#{self.user.first_name} #{self.user.last_name} booked a #{field.field_type} for #{from_time.strftime("%a")}", data: {request: self, field: field, user: field.group.arena.user}},
            NotificationHelper.types[:BOOKING_REQUEST_RECIEVED]
        )
    end
    after_update do
        NotificationHelper.send(
            user.devices.pluck(:fcm_token),
            { title: "Booking Request Accepted", body:"Your request for #{field.field_type} at #{from_time.strftime("%a")} has been accepted", data: {request: self, field: field, user: field.group.arena.user}},
            NotificationHelper.types[:BOOKING_REQUEST_ACCEPTED]
        )
    end
    def booking_available
        # records_in_time = field.arena_booking_requests.where(from_time: from_time..to_time, status:"Accepted").or(arena.arena_booking_requests.where(to_time: from_time..to_time,status:"Accepted"))
        requests = field.arena_booking_requests
        records_in_time = requests.where("from_time <= '#{from_time.to_time}' and to_time >= '#{from_time.to_time}' and status > 0 ")
                .or(requests.where("from_time <= '#{to_time.to_time}' and to_time >= '#{to_time.to_time}' and status > 0 "))
                .or(requests.where("from_time >= '#{from_time.to_time}' and to_time <= '#{to_time.to_time}' and status > 0 "))
        if records_in_time.size>0
            errors.add(:from_time, "the #{field.field_type} is not available for this duration")
        end
    end
    def times_are_valid
        if from_time>=to_time
            errors.add(:from_time, "From Time cant be same as or after To Time")
            errors.add(:to_time, "To Time cant be same as or before From Time")
        end
    end

end
