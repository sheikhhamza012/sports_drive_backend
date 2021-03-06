class AddColToArenaBookingRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :arena_booking_requests, :allow_individual_requests, :boolean
  end
end
