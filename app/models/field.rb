class Field < ApplicationRecord
    belongs_to :group
    mount_uploader :image, ImageUploader

end
