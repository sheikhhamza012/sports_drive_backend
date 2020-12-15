class UpdateColsofArena < ActiveRecord::Migration[6.0]
  def change
    change_column :arenas, :location, :jsonb,default:{},using:'CAST(location AS JSON)'
    remove_column :arenas, :sports
  end
end
