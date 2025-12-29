class Contract < ApplicationRecord
  belongs_to :resident

  validates :start_date, presence: true
end