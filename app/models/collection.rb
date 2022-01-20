# Model for a named collection of items
#
# A collection can exist without containing any items. If the collection is deleted, all of its
# items are deleted as well.
#
# A collection has these attributes:
# - name: required; max 255 chars; unique
# - description: required; max 5,000 chars
#
# @author soir20
class Collection < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 255 }
  validates :name, uniqueness: true

  validates :description, presence: true
  validates :description, length: { maximum: 5_000 }

  has_many :inventory_items, dependent: :destroy
end
