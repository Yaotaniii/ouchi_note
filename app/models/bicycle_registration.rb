class BicycleRegistration < ApplicationRecord
  belongs_to :resident

  validates :registration_number, presence: true, uniqueness: true
end