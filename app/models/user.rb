class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :role, presence: true, inclusion: { in: %w[owner staff] }

  def owner?
    role == 'owner'
  end

  def staff?
    role == 'staff'
  end
end