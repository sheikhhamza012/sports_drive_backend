class Field < ApplicationRecord
    belongs_to :group
    mount_uploader :image, ImageUploader
    has_many :prices,as: :priceable,dependent: :destroy

end
