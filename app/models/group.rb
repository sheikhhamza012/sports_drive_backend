class Group < ApplicationRecord
    belongs_to :arena
    has_many :fields,dependent: :destroy
end
