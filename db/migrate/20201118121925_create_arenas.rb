class CreateArenas < ActiveRecord::Migration[6.0]
  def change
    create_table :arenas do |t|
      t.belongs_to :user
      t.string :name
      t.string :location
      t.string :image
      t.integer :sports
      t.timestamps
    end
  end
end
