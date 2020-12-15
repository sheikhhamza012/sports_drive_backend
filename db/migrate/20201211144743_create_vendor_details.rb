class CreateVendorDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :vendor_details do |t|
      t.belongs_to :user
      t.string :id_card
      t.integer :request_status
      t.timestamps
    end
  end
end
