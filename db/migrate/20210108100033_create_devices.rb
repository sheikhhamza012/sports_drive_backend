class CreateDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :devices do |t|
      t.string :fcm_token
      t.belongs_to :user
      t.timestamps
    end
  end
end
