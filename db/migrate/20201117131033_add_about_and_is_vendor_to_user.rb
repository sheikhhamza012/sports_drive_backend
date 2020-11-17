class AddAboutAndIsVendorToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :isVendor, :boolean, default: false
    add_column :users, :about, :string
    add_column :users, :featured, :string
    add_column :users, :player_of, :int
    add_column :users, :rating, :int ,default: 0

  end
end
