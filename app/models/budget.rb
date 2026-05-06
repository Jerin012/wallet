class Budget < ApplicationRecord
  has_many :expenses, dependent: :destroy
  validates :amount, presence: true, numericality: { greater_than: 0 }

  def total_spent
    expenses.sum(:amount)
  end

  def remaining
    amount - total_spent
  end
end