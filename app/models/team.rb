class Team < ApplicationRecord
    validates :name, presence: true
    validates :category, presence: true
    validates :no_of_players, presence: true
    validates :city, presence: true
    # validates :image, presence: true
    validates :description, presence: true
    mount_uploader :image, ImageUploader
    belongs_to :captain, class_name: 'User', foreign_key: 'user_id'
    has_many :users

    enum category: ["Cricket","Football","Basket Ball","Badminton","Squash","Swimming","Tennis","Table Tenis"]
end
