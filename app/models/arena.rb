class Arena < ApplicationRecord
    belongs_to :user
    validates :name, presence: true
    validates :location, presence: true
    mount_uploader :image, ImageUploader

    has_many :arena_booking_requests, dependent: :destroy
    has_many :arenas, as: :booked_users,through: :arena_booking_requests, dependent: :destroy
    has_many :groups, dependent: :destroy
    
    def self.get_available_arenas(location,from_time,to_time)
        
        joined = joins('left join arena_booking_requests on arenas.id = arena_booking_requests.arena_id')
        records = joined.where("arena_booking_requests.from_time is NULL")
        .or(
            joined
            .where.not("arena_booking_requests.from_time >= '#{from_time.to_time}' and arena_booking_requests.from_time <= '#{to_time.to_time}' and status > 0 ")
            .where.not("arena_booking_requests.to_time >= '#{from_time.to_time}' and arena_booking_requests.to_time <= '#{to_time.to_time}' and status > 0 ")
            .where.not("arena_booking_requests.from_time <= '#{from_time.to_time}' and arena_booking_requests.from_time >= '#{from_time.to_time}' and status > 0 ")
            .where.not("arena_booking_requests.from_time <= '#{to_time.to_time}' and arena_booking_requests.from_time >= '#{to_time.to_time}' and status > 0 ")
        )
        .where("location ILIKE ?", "%#{location}%")
        return records
        
    end
    
end
