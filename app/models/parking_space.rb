class ParkingSpace < ApplicationRecord
  belongs_to :resident, optional: true

  validates :space_number, presence: true, uniqueness: true
  validates :user_type, presence: true, inclusion: { in: %w[resident owner] }

  def available?
    resident.nil? && user_type == 'resident'
  end

  def owner_use?
    user_type == 'owner'
  end
end