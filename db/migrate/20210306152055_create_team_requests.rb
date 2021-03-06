class CreateTeamRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :team_requests do |t|
      t.belongs_to :user
      t.belongs_to :team
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
