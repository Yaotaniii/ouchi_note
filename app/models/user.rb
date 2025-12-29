class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :role, presence: true, inclusion: { in: %w[owner staff] }

  def owner?
    role == 'owner'
  end

  def staff?
    role == 'staff'
  end
end