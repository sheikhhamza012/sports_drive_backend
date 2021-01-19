class AddInstantBookingToGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :allow_instant_booking, :boolean ,default: false
  end
end
