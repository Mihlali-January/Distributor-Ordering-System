class Order < ApplicationRecord
  belongs_to :distributor
  belongs_to :user
  has_many :order_items, dependent: :destroy

  validates :order_number, presence: true, uniqueness: true
  validates :required_delivery_date, presence: true
  validate :required_delivery_date_cannot_be_in_the_past

  before_validation :generate_order_number, on: :create

  private

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
