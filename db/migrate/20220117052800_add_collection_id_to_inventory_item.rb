class AddCollectionIdToInventoryItem < ActiveRecord::Migration[7.0]
  def change
    add_column :inventory_items, :collection_id, :integer
  end
end
