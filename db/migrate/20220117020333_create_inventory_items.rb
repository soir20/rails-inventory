class CreateInventoryItems < ActiveRecord::Migration[7.0]
  def change
    create_table :inventory_items do |t|
      t.string :name
      t.text :description
      t.integer :quantity
      t.decimal :unit_volume, precision: 20, scale: 4
      t.decimal :unit_weight, precision: 20, scale: 4
      t.boolean :is_frozen
      t.boolean :is_fragile

      t.timestamps
    end
  end
end
