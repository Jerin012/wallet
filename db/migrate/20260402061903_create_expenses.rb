class CreateExpenses < ActiveRecord::Migration[8.1]
  def change
    create_table :expenses do |t|
      t.string :description
      t.decimal :amount
      t.string :category
      t.date :expense_date
      t.references :budget, null: false, foreign_key: true

      t.timestamps
    end
  end
end
