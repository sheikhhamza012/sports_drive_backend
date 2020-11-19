class Arena < ApplicationRecord
    belongs_to :user
    validates :name, presence: true
    validates :location, presence: true
    validates :sports, presence: true
    mount_uploader :image, ImageUploader

    enum sports: ["Cricket","Football","Basket Ball","Badminton","Squash","Swimming","Tennis","Table Tenis"]
    has_many :arena_booking_requests, dependent: :destroy
    has_many :arenas, as: :booked_users,through: :arena_booking_requests, dependent: :destroy

   
end
