class ChangeBelongsToArenaBookinRequest < ActiveRecord::Migration[6.0]
  def change
    change_table :arena_booking_requests do |t|
      t.remove_references :arena
      t.belongs_to :field
    end
  end
end
