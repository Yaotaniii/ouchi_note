class Resident < ApplicationRecord
  belongs_to :room

  has_one :contract, dependent: :destroy
  has_many :vehicles, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :incidents, dependent: :destroy
  has_many :bicycle_registrations, dependent: :destroy
  has_many :motorcycle_registrations, dependent: :destroy

  validates :name, presence: true
  validates :move_in_date, presence: true
  validates :occupants_count, numericality: { greater_than_or_equal_to: 1 }, allow_nil: true

  def current?
    move_out_date.nil?
  end
end