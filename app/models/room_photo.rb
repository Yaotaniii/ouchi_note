class RoomPhoto < ApplicationRecord
  belongs_to :room

  validates :photo_type, presence: true, inclusion: { in: %w[move_in move_out] }

  def move_in?
    photo_type == 'move_in'
  end

  def move_out?
    photo_type == 'move_out'
  end
end