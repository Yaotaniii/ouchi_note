class Resident < ApplicationRecord
  belongs_to :room

  has_one :contract
  has_many :vehicles
  has_many :bicycle_registrations
  has_many :motorcycle_registrations
  has_many :payments
  has_many :incidents

  validates :name, presence: true
  validates :move_in_date, presence: true

  def current?
    move_out_date.nil?
  end

  def moved_out?
    move_out_date.present?
  end
end