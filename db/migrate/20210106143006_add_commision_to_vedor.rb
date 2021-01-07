class AddCommisionToVedor < ActiveRecord::Migration[6.0]
  def change
    add_column :vendor_details, :commission, :decimal ,default: 0
  end
end
