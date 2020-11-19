class CreateArenaBookingRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :arena_booking_requests do |t|
      t.datetime :from_time
      t.datetime :to_time
      t.integer :status, default: 0
      t.belongs_to :user
      t.belongs_to :arena
      t.timestamps
    end
  end
end
