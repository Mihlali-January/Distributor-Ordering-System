class Product < ApplicationRecord
  has_many :skus, dependent: :destroy

  VALID_VOLUMES = ["25ml (0.85 oz)", "60ml (2 oz)", "125ml (4.2 oz)", "200ml (6.7 oz)"].freeze

  validates :name, presence: true, uniqueness: true
  validates :volume, presence: true, inclusion: { in: VALID_VOLUMES }
end
