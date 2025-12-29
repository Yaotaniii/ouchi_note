class MaintenanceRecord < ApplicationRecord
  belongs_to :room

  validates :title, presence: true
  validates :performed_on, presence: true
  validates :cost, numericality: { greater_than_or_equal_to: 0 }
end