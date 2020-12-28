class Arena < ApplicationRecord
    belongs_to :user
    validates :name, presence: true
    validates :location, presence: true
    mount_uploader :image, ImageUploader

    has_many :groups, dependent: :destroy
    
    def self.get_available_arenas(location,from_time,to_time,group)
        
        joined = joins("left join groups on arenas.id = groups.arena_id and groups.name = '#{group}' left join fields on
            groups.id = fields.group_id left join arena_booking_requests on fields.id = arena_booking_requests.field_id")
        records_to_exclude = joined.where("arena_booking_requests.from_time > '#{from_time.to_time}' and arena_booking_requests.from_time < '#{to_time.to_time}' and status > 0 ")
        .or(joined.where("arena_booking_requests.to_time > '#{from_time.to_time}' and arena_booking_requests.to_time < '#{to_time.to_time}'and status > 0 "))
        .or(joined.where("arena_booking_requests.from_time <= '#{from_time.to_time}' and arena_booking_requests.from_time <= '#{to_time.to_time}' and arena_booking_requests.to_time >= '#{from_time.to_time}' and arena_booking_requests.to_time >= '#{to_time.to_time}' and status > 0 "))
        
        records = joined.where('fields.id not in (?)', records_to_exclude.present? ? records_to_exclude.pluck("fields.id") : [-1])
                .where("arenas.location ->> 'address' ILIKE ?", "%#{location}%")
                .uniq
        
        
        # .or(
        #     joined
        #     .where("arena_booking_requests.from_time < '#{from_time.to_time}' and arena_booking_requests.to_time <= '#{to_time.to_time}' and status > 0 ")
            
        # )
        # .or(joined.where("arena_booking_requests.from_time >= '#{to_time.to_time}' and arena_booking_requests.to_time > '#{from_time.to_time}' and status > 0 ")
        # ).uniq
        

        return records
        
    end
    
end
