# Model for an individual item in the inventory.
#
# An item may or may not be part of a collection, and it can be added to and
# removed from a collection as necessary. An item may only be part of one collection.
#
# An inventory item has the following attributes:
# - name: required; max 255 chars; unique
# - description: required; max 5,000 chars
# - quantity: required; between 0 and max 32-bit signed int
# - unit volume: required; volume per unit of the item (could be in grams as a standard); > 0; rounded if more than
#                four decimal places; max 20 digits
# - unit volume: required; volume per unit of the item (could be in grams as a standard); > 0; rounded if more than
#                four decimal places; max 20 digits
# - is frozen: required; whether or not the item is frozen and needs special transportation/storage; defaults to false
# - is fragile: required; whether or not the item is fragile and needs special transportation/storage; defaults to false
# - collection ID: optional; must be the ID of an existing collection if provided; this item will be destroyed when
#                  the associated collection is destroyed
#
# @author soir20
class InventoryItem < ApplicationRecord
  public

  # Gets the name of the collection this item is associated with, or returns nil if
  # it is not associated with a collection.
  # @return [String, nil] the name of the associated collection or nil
  def collection_name
    self.collection_id.present? ? Collection.find(self.collection_id).name : nil
  end

  private

  # Gets the max integer value we want to allow or that is supported by the database.
  # @return [Integer] max integer value
  def self.int_max
    2_147_483_647
  end

  # Gets the maximum value of a decimal with the given precision and scale.
  # @param precision      maximum number of digits
  # @parma scale          maximum number of digits to the right of the decimal
  # @return [Complex] the decimal's maximum value
  def self.max_decimal(precision, scale)
    10r ** (precision - scale) - 10r ** -scale
  end

  validates :name, presence: true
  validates :name, length: { maximum: 255 }

  validates :description, presence: true
  validates :description, length: { maximum: 5_000 }

  validates :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, in: 0..InventoryItem.int_max }

  validates :unit_volume, :unit_weight, presence: true
  validates :unit_volume, :unit_weight, numericality: { in: 0..max_decimal(20, 4) }

  attribute :is_frozen, :boolean, default: false
  attribute :is_fragile, :boolean, default: false

  belongs_to :collection, optional: true
  validates :collection, presence: { message: 'must exist' }, if: -> { collection_id.present? }

end
