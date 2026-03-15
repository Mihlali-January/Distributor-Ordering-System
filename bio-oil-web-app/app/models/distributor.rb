class Distributor < ApplicationRecord
  has_many :users, dependent: :destroy
  accepts_nested_attributes_for :users
  has_many :skus, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :currency, presence: true
end
