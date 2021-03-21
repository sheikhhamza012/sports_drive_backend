class ChangeImageToImages < ActiveRecord::Migration[6.0]
  def change
    change_column :arenas, :image, :jsonb,using:'CAST(image AS JSON)'
    rename_column :arenas, :image, :images

  end
end
