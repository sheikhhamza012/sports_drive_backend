class AddCollToArenaBookingRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :arena_booking_requests, :allow_challenge_requests, :boolean
  end
end
