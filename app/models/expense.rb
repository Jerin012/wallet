class Expense < ApplicationRecord
  belongs_to :budget
  validates :description, :amount, :category, :expense_date, presence: true
  validates :amount, numericality: { greater_than: 0 }

  CATEGORIES = %w[food transport shopping health entertainment other].freeze
end