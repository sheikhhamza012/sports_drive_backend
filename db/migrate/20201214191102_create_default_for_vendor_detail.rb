class CreateDefaultForVendorDetail < ActiveRecord::Migration[6.0]
  def change
    change_column :vendor_details, :request_status, :integer ,default:0
  
  end
end
