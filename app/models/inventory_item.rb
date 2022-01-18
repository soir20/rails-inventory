class InventoryItem < ApplicationRecord
  public

  def collection_name
    self.collection_id.present? ? Collection.find(self.collection_id).name : nil
  end

  private

  def self.int_max
    2_147_483_647
  end

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
