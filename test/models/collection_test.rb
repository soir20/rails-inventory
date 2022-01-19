require "test_helper"

class CollectionTest < ActiveSupport::TestCase
  test "cannot create collection without name" do
    collection = Collection.new
    collection.description = "description"
    assert_not collection.save
  end

  test "cannot create collection with blank name" do
    collection = Collection.new
    collection.name = "    "
    collection.description = "description"
    assert_not collection.save
  end

  test "create collection with name exactly 255 characters" do
    collection = Collection.new
    collection.name = "a" * 255
    collection.description = "description"
    assert collection.save
  end

  test "cannot create collection with name longer than 255 characters" do
    collection = Collection.new
    collection.name = "a" * 256
    collection.description = "description"
    assert_not collection.save
  end

  test "cannot create collection with name much longer than 255 characters" do
    collection = Collection.new
    collection.name = "a" * 1_255
    collection.description = "description"
    assert_not collection.save
  end

  test "cannot create collection without description" do
    collection = Collection.new
    collection.name = "name"
    assert_not collection.save
  end

  test "cannot create collection with blank description" do
    collection = Collection.new
    collection.name = "name"
    collection.description = "    "
    assert_not collection.save
  end

  test "create collection with description longer than 5,000 characters" do
    collection = Collection.new
    collection.name = "name"
    collection.description = "a" * 5_000
    assert collection.save
  end

  test "cannot create collection with description longer than 5,000 characters" do
    collection = Collection.new
    collection.name = "name"
    collection.description = "a" * 5_001
    assert_not collection.save
  end

  test "cannot create collection with description much longer than 5,000 characters" do
    collection = Collection.new
    collection.name = "name"
    collection.description = "a" * 15_000
    assert_not collection.save
  end

  test "cannot create two collections with the same name" do
    collection = Collection.new
    collection.name = "name"
    collection.description = "description"
    assert collection.save

    collection2 = Collection.new
    collection2.name = "name"
    collection2.description = "other description"
    assert_not collection2.save
  end

  test "create two collections with the same description" do
    collection = Collection.new
    collection.name = "name"
    collection.description = "description"
    assert collection.save

    collection2 = Collection.new
    collection2.name = "other name"
    collection2.description = "description"
    assert collection2.save
  end

  test "create two collections with different names and descriptions" do
    collection = Collection.new
    collection.name = "name"
    collection.description = "description"
    assert collection.save

    collection2 = Collection.new
    collection2.name = "other name"
    collection2.description = "other description"
    assert collection2.save
  end

  test "create collection with non-ASCII name" do
    collection = Collection.new
    collection.name = "á, é, í, ó, ú, ü, ñ, ¿, ¡"
    collection.description = "description"
    assert collection.save
  end

  test "create collection with non-ASCII description" do
    collection = Collection.new
    collection.name = "name"
    collection.description = "á, é, í, ó, ú, ü, ñ, ¿, ¡"
    assert collection.save
  end

  test "deleting collection deletes associated items" do
    collection = Collection.new
    collection.name = "name"
    collection.description = "description"
    assert collection.save

    item = InventoryItem.new
    item.name = "name"
    item.description = "description"
    item.quantity = 1
    item.unit_volume = 1.0
    item.unit_weight = 1.0
    item.is_frozen = false
    item.is_fragile = false
    item.collection_id = collection.id
    assert item.save

    assert_difference("InventoryItem.count", -1) do
      collection.destroy
    end
  end
end
