class AddColsToTeams < ActiveRecord::Migration[6.0]
  def change
    change_table :teams do |t|
      t.belongs_to :user
    end
    change_table :users do |t|
      t.belongs_to :team
    end
  end
end
