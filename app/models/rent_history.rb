class RentHistory < ApplicationRecord
  belongs_to :room

  validates :rent, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :started_on, presence: true
end