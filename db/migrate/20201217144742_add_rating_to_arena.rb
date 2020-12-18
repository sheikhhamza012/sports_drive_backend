class AddRatingToArena < ActiveRecord::Migration[6.0]
  def change
    add_column :arenas, :rating, :int, default: 0

  end
end
