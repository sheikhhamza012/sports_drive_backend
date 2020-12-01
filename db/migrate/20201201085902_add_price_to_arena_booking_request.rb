class AddPriceToArenaBookingRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :arena_booking_requests, :price, :int, default:0
  end
end
