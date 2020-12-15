class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.integer :capacity
      t.string :name
      t.belongs_to :arena
      t.timestamps
    end
  end
end
