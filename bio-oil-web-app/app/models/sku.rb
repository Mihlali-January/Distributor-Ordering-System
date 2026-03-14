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

  # Generate a unique recognizable SKU Code (e.g. SA-SKIN-60ML)
  def sku_code
    dist_prefix = distributor&.name&.split(/[^a-zA-Z]/)&.map(&:first)&.join&.upcase&.first(3) || "XXX"
    prod_prefix = product&.name&.split(/[^a-zA-Z]/)&.map(&:first)&.join&.upcase || "PROD"
    vol = product&.volume&.upcase || "XX"
    "#{dist_prefix}-#{prod_prefix}-#{vol}"
  end
end
