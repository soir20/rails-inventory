json.extract! inventory_item, :id, :name, :description, :quantity, :unit_volume, :unit_weight, :is_frozen, :is_fragile, :created_at, :updated_at
json.url inventory_item_url(inventory_item, format: :json)
