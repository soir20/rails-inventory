require "test_helper"

class InventoryItemTest < ActiveSupport::TestCase
  setup do
    @collection_id = collections(:one).id
  end

  test "cannot create item without name" do
    item = InventoryItem.new
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id
    assert_not item.save
  end

  test "cannot create item with blank name" do
    item = InventoryItem.new
    item.name = "   "
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id
    assert_not item.save
  end

  test "create item with name exactly 255 characters" do
    item = InventoryItem.new
    item.name = "a" * 255
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id
    assert item.save
  end

  test "cannot create item with name longer than 255 characters" do
    item = InventoryItem.new
    item.name = "a" * 256
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id
    assert_not item.save
  end

  test "cannot create item with name much longer than 255 characters" do
    item = InventoryItem.new
    item.name = "a" * 1_255
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id
    assert_not item.save
  end

  test "cannot create item without description" do
    item = InventoryItem.new
    item.name = "name"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id
    assert_not item.save
  end

  test "cannot create item with blank description" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "    "
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id
    assert_not item.save
  end


  test "create item with description longer than 5,000 characters" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "a" * 5_000
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id
    assert item.save
  end

  test "cannot create item with description longer than 5,000 characters" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "a" * 5_001
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id
    assert_not item.save
  end

  test "cannot create item with description much longer than 5,000 characters" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "a" * 15_000
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id
    assert_not item.save
  end

  test "create two items with the same name" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id
    assert item.save

    item2 = InventoryItem.new
    item2.name = "name"
    item2.description = "other description"
    item2.quantity = 1
    item2.unit_volume = 1.0
    item2.unit_weight = 1.0
    item2.is_frozen = false
    item2.is_fragile = false
    item2.collection_id = @collection_id
    assert item2.save
  end

  test "create two items with the same description" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id
    assert item.save

    item2 = InventoryItem.new
    item2.name = "other name"
    item2.description = "description"
    item2.quantity = 1
    item2.unit_volume = 1.0
    item2.unit_weight = 1.0
    item2.is_frozen = false
    item2.is_fragile = false
    item2.collection_id = @collection_id
    assert item2.save
  end

  test "create two items with different names and descriptions" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id
    assert item.save

    item2 = InventoryItem.new
    item2.name = "other name"
    item2.description = "other description"
    item2.quantity = 1
    item2.unit_volume = 1.0
    item2.unit_weight = 1.0
    item2.is_frozen = false
    item2.is_fragile = false
    item2.collection_id = @collection_id
    assert item2.save
  end

  test "create item with non-ASCII name" do
    item = InventoryItem.new
    item.name = "á, é, í, ó, ú, ü, ñ, ¿, ¡"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id
    assert item.save
  end

  test "create item with non-ASCII description" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "á, é, í, ó, ú, ü, ñ, ¿, ¡"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id
    assert item.save
  end

  test "cannot create item with negative integer quantity" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = -1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id
    assert_not item.save
  end

  test "cannot create item with negative decimal quantity" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = -1.5
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id
    assert_not item.save
  end

  test "create item with zero quantity" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 0
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id
    assert item.save
  end

  test "cannot create item with positive decimal quantity" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1.5
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id
    assert_not item.save
  end

  test "create item with positive integer quantity" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 10
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id
    assert item.save
  end

  test "create item with integer max quantity" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 2_147_483_647
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id
    assert item.save
  end

  test "cannot create item with greater than integer max quantity" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 2_147_483_648
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id
    assert_not item.save
  end

  test "cannot create item with much greater than integer max quantity" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 40_000_000_000
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id
    assert_not item.save
  end

  test "create item with negative decimal volume" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = -1.5
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id
    assert_not item.save
  end

  test "create item with truncated negative decimal volume" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = -0.00001
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id

    assert item.save
  end

  test "create item with zero decimal volume" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id

    assert item.save
  end

  test "create item with truncated positive decimal volume" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 0.00001
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id

    assert item.save
  end

  test "create item with positive decimal volume" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 5.5
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id

    assert item.save
  end

  test "create item with max decimal volume" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 9_999_999_999_999_999.9999
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id

    assert item.save
  end

  test "create item with truncated max decimal volume" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 9_999_999_999_999_999.99996
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id

    assert item.save
  end

  test "create item with more than max decimal volume" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 10_000_000_000_000_000
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id

    assert_not item.save
  end

  test "cannot create item with negative decimal weight" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = -1.5
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id
    assert_not item.save
  end

  test "create item with truncated negative decimal weight" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = -0.00001
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id

    assert item.save
  end

  test "create item with zero decimal weight" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id

    assert item.save
  end

  test "create item with truncated positive decimal weight" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 0.00001
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id

    assert item.save
  end

  test "create item with positive decimal weight" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 5.5
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id

    assert item.save
  end

  test "create item with max decimal weight" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 9_999_999_999_999_999.9999
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id

    assert item.save
  end

  test "create item with truncated max decimal weight" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 9_999_999_999_999_999.99996
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id

    assert item.save
  end

  test "cannot create item with more than max decimal weight" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 10_000_000_000_000_000
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id

    assert_not item.save
  end

  test "create item neither frozen nor fragile" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id

    assert item.save
  end

  test "create item frozen" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = true
    item.is_fragile = false
    item.collection_id = @collection_id

    assert item.save
  end

  test "create item fragile" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = true
    item.collection_id = @collection_id

    assert item.save
  end

  test "create item frozen and fragile" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = true
    item.is_fragile = true
    item.collection_id = @collection_id

    assert item.save
  end

  test "create item defaults not frozen" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_fragile = false
    item.collection_id = @collection_id

    assert item.save
    assert_not item.is_frozen
  end

  test "create item defaults not fragile" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.collection_id = @collection_id

    assert item.save
    assert_not item.is_fragile
  end

  test "create item no collection ID" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false

    assert item.save
  end

  test "create item existing collection ID" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = @collection_id

    assert item.save
  end

  test "cannot create item nonexistent collection ID" do
    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = 1_000_000_000 # we shouldn't have a collection ID this high in sample data

    assert_not item.save
  end

end
