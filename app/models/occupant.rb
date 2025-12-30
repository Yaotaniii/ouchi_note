class Occupant < ApplicationRecord
  belongs_to :resident

  validates :name, presence: true
end