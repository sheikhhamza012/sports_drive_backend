class AddNameToField < ActiveRecord::Migration[6.0]
  def change
    add_column :fields, :name, :string 
  end
end
