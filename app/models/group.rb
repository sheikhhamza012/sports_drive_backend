class Group < ApplicationRecord
    belongs_to :arena
    has_many :fields,dependent: :destroy
    has_many :prices,as: :priceable,dependent: :destroy
    
end
