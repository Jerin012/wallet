class AddMonthToBudgets < ActiveRecord::Migration[8.1]
  def change
    add_column :budgets, :month, :string
  end
end
