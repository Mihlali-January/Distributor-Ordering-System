class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { admin: 0, distributor: 1 }, default: :distributor

  belongs_to :distributor, optional: true

  validates :role, presence: true
  validate :distributor_presence_for_distributor_role

  private

  def distributor_presence_for_distributor_role
    if distributor? && distributor_id.blank?
      errors.add(:distributor, "must be present for distributor users")
    elsif admin? && distributor_id.present?
      errors.add(:distributor, "must be blank for admin users")
    end
  end
end
