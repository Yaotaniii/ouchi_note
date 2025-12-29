class Incident < ApplicationRecord
  belongs_to :resident
  belongs_to :room, optional: true

  validates :incident_type, presence: true, inclusion: { in: %w[complaint trouble inquiry other] }
  validates :title, presence: true
  validates :occurred_on, presence: true
  validates :status, presence: true, inclusion: { in: %w[open resolved] }

  def open?
    status == 'open'
  end

  def resolved?
    status == 'resolved'
  end
end