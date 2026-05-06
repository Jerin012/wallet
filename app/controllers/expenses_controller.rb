class ExpensesController < ApplicationController
  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    if @expense.save
      redirect_to root_path, notice: "Expense added successfully!"
    else
      redirect_to root_path, alert: "Failed to add expense."
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    redirect_to root_path, notice: "Expense deleted."
  end

  private

  def expense_params
    params.require(:expense).permit(:description, :amount, :category, :expense_date, :budget_id)
  end
end