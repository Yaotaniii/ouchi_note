class BicycleRegistration < ApplicationRecord
  belongs_to :resident

  validates :registration_number, presence: true, uniqueness: true
  validates :bicycle_count, numericality: { greater_than: 0 }
end