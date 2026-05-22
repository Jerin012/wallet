class AddMonthToExpenses < ActiveRecord::Migration[8.1]
  def change
    add_column :expenses, :month, :string
  end
end
