require "test_helper"

class InventoryItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @inventory_item = inventory_items(:one)
  end

  test "should get index" do
    get inventory_items_url
    assert_response :success
  end

  test "should get new" do
    get new_inventory_item_url
    assert_response :success
  end

  test "should create inventory_item" do
    assert_difference("InventoryItem.count") do
      post inventory_items_url, params: { inventory_item: {
        description: @inventory_item.description, is_fragile: @inventory_item.is_fragile,
        is_frozen: @inventory_item.is_frozen, name: @inventory_item.name, quantity: @inventory_item.quantity,
        unit_volume: @inventory_item.unit_volume, unit_weight: @inventory_item.unit_weight,
        collection_id: @inventory_item.collection_id
      } }
    end

    assert_redirected_to inventory_item_url(InventoryItem.last)
  end

  test "should show inventory_item" do
    get inventory_item_url(@inventory_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_inventory_item_url(@inventory_item)
    assert_response :success
  end

  test "should update inventory_item" do
    patch inventory_item_url(@inventory_item), params: { inventory_item: {
      description: @inventory_item.description, is_fragile: @inventory_item.is_fragile,
      is_frozen: @inventory_item.is_frozen, name: @inventory_item.name, quantity: @inventory_item.quantity,
      unit_volume: @inventory_item.unit_volume, unit_weight: @inventory_item.unit_weight,
      collection_id: @inventory_item.collection_id
    } }
    assert_redirected_to inventory_item_url(@inventory_item)
  end

  test "should destroy inventory_item" do
    assert_difference("InventoryItem.count", -1) do
      delete inventory_item_url(@inventory_item)
    end

    assert_redirected_to inventory_items_url
  end
end
