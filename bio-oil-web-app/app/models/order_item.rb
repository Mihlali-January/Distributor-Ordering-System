class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :sku

  validates :pallets, presence: true, numericality: { greater_than: 0, only_integer: true }

  before_save :calculate_totals

  private

  def calculate_totals
    return unless pallets.present? && sku.present?

    # 1 pallet = 4,800 units
    self.units = pallets * 4800
    self.cost = units * sku.price_per_unit
  end
end
