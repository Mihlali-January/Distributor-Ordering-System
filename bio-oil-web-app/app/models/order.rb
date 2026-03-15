class Order < ApplicationRecord
  belongs_to :distributor
  belongs_to :user
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items, allow_destroy: true

  validates :order_number, presence: true, uniqueness: true
  validates :required_delivery_date, presence: true
  validate :required_delivery_date_cannot_be_in_the_past
  validate :must_have_items

  accepts_nested_attributes_for :order_items, 
                                allow_destroy: true,
                                reject_if: proc { |attributes| attributes['pallets'].to_i <= 0 }

  before_validation :generate_order_number, on: :create
  before_save :calculate_total_cost

  private

  def must_have_items
    errors.add(:base, "Order must contain at least one item with a quantity greater than zero") if order_items.empty? || order_items.all?(&:marked_for_destruction?)
  end

  def calculate_total_cost
    self.total_cost = order_items.map { |i| i.cost || 0 }.sum
  end

  def required_delivery_date_cannot_be_in_the_past
    if required_delivery_date.present? && required_delivery_date < Date.today
      errors.add(:required_delivery_date, "can't be in the past")
    end
  end

  def generate_order_number
    return if order_number.present?
    
    loop do
      # Example format: ORD-1002
      self.order_number = "ORD-#{SecureRandom.random_number(1_000_000).to_s.rjust(6, '0')}"
      break unless Order.exists?(order_number: order_number)
    end
  end
end
