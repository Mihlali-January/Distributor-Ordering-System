class Sku < ApplicationRecord
  belongs_to :product
  belongs_to :distributor
  has_many :order_items, dependent: :destroy

  validates :price_per_unit, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  # Ensure a distributor can't have multiple SKUs for the same product
  validates :product_id, uniqueness: { scope: :distributor_id, message: "already has an SKU for this distributor" }

  # The SKU name is derived from the product name
  def name
    product&.name
  end
end
