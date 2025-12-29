class Payment < ApplicationRecord
  belongs_to :resident

  validates :year_month, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true, inclusion: { in: %w[paid unpaid] }
  validates :resident_id, uniqueness: { scope: :year_month, message: 'この月の入金記録は既に存在します' }

  def paid?
    status == 'paid'
  end

  def unpaid?
    status == 'unpaid'
  end
end