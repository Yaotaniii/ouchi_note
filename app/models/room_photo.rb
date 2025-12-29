class RoomPhoto < ApplicationRecord
  belongs_to :room

  has_one_attached :image

  validates :photo_type, presence: true, inclusion: { in: %w[move_in move_out] }
  validates :image, presence: true

  def move_in?
    photo_type == 'move_in'
  end

  def move_out?
    photo_type == 'move_out'
  end
end