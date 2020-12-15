class CreateFields < ActiveRecord::Migration[6.0]
  def change
    create_table :fields do |t|
      t.string :field_type
      t.string :image
      t.belongs_to :group
      t.timestamps
    end
  end
end
