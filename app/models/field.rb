class Field < ApplicationRecord
    belongs_to :group
    mount_uploader :image, ImageUploader
    has_many :prices,as: :priceable,dependent: :destroy
    has_many :arena_booking_requests, dependent: :destroy
    def check_availabilty(from_time,to_time)
        records_in_time = arena_booking_requests.where("from_time > '#{from_time.to_time}' and from_time < '#{to_time.to_time}' and status > 0 ")
                .or(arena_booking_requests.where("to_time > '#{from_time.to_time}' and to_time < '#{to_time.to_time}'and status > 0 "))
                .or(arena_booking_requests.where("from_time <= '#{from_time.to_time}' and from_time <= '#{to_time.to_time}' and to_time >= '#{from_time.to_time}' and to_time >= '#{to_time.to_time}' and status > 0 "))
        if records_in_time.size>0
            return false
        end
        return true
    end

end
