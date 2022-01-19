class Collection < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 255 }
  validates :name, uniqueness: true

  validates :description, presence: true
  validates :description, length: { maximum: 5_000 }

  has_many :inventory_items, dependent: :destroy
end
