class Room < ApplicationRecord
  has_many :residents
  has_many :maintenance_records
  has_many :room_photos
  has_many :rent_histories
  has_many :room_vacancies
  has_many :incidents

  validates :room_number, presence: true, uniqueness: true
  validates :status, presence: true, inclusion: { in: %w[vacant occupied] }

  def current_resident
    residents.where(move_out_date: nil).order(move_in_date: :desc).first
  end

  def occupied?
    status == 'occupied'
  end

  def vacant?
    status == 'vacant'
  end
end