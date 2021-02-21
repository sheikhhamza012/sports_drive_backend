class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :category
      t.integer :no_of_players
      t.string :city
      t.string :image
      t.string :description
      t.timestamps
    end
  end
end
