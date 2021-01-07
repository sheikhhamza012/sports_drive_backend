class Price < ApplicationRecord
    belongs_to :priceable, polymorphic: true
    validates :to_time, presence: true
    validates :from_time, presence: true
    validates :name, presence: true
    validates :price_type, presence: true
    validates :price, presence: true,numericality: { greater_than: 0 }
    # validate :times_are_valid, :on => :create
    enum price_type: ["Peak","Off Peak","Weekend","Individual Field"]
    def times_are_valid
        if from_time>=to_time
            errors.add(:from_time, "From Time cant be same as or after To Time")
            errors.add(:to_time, "To Time cant be same as or before From Time")
        end
    end
end
