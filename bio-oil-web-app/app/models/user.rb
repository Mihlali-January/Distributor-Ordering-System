class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  attr_accessor :login

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  enum :role, { admin: 0, distributor: 1 }, default: :distributor

  belongs_to :distributor, optional: true

  validates :role, presence: true
  validates :username, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
  
  validate :distributor_presence_for_distributor_role

  def full_name
    "#{first_name} #{last_name}"
  end

  def name_with_email
    "#{full_name} (#{email})"
  end

  private

  def distributor_presence_for_distributor_role
    if distributor? && distributor_id.blank?
      errors.add(:distributor, "must be present for distributor users")
    elsif admin? && distributor_id.present?
      errors.add(:distributor, "must be blank for admin users")
    end
  end
end
