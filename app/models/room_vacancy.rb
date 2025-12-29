class RoomVacancy < ApplicationRecord
  belongs_to :room

  validates :vacant_from, presence: true

  def days_vacant
    end_date = vacant_until || Date.today
    (end_date - vacant_from).to_i
  end

  def ongoing?
    vacant_until.nil?
  end
end