class Vehicle < ApplicationRecord
  belongs_to :resident

  validates :vehicle_type, presence: true, inclusion: { in: %w[car motorcycle] }

  def car?
    vehicle_type == 'car'
  end

  def motorcycle?
    vehicle_type == 'motorcycle'
  end
end