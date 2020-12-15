class VendorDetail < ApplicationRecord
    belongs_to :user
    enum request_status: [:pending, :approved, :rejected]

end
