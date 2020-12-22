class CreatePrices < ActiveRecord::Migration[6.0]
  def change
    create_table :prices do |t|
      t.bigint  :priceable_id
      t.string  :priceable_type
      t.string :name
      t.date :date
      t.time :from_time
      t.time :to_time
      t.integer :price
      t.integer :price_type
      t.timestamps
    end
  end
end
