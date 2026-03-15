class Distributor < ApplicationRecord
  has_many :users, dependent: :destroy
  accepts_nested_attributes_for :users
  has_many :skus, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :distributor_code, presence: true, uniqueness: true
  validates :currency, presence: true
  validates :contact_email, format: { with: Devise.email_regexp }, allow_blank: true

  scope :active, -> { where(active: true) }

  def display_name
    "#{name} [#{distributor_code}]"
  end
end
