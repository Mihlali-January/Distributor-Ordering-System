class Product < ApplicationRecord
  has_many :skus, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :volume, presence: true
end
