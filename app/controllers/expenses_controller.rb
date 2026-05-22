class ExpensesController < ApplicationController
  def new
    @expense = Expense.new
  end

  def create
    current_month = Date.today.strftime("%B %Y")
    budget = Budget.find_by(month: current_month)
    if budget.nil?
        redirect_to root_path, alert: "Set budget first"
        return
    end
    @expense = Expense.new(expense_params)
    @expense.month = current_month
    @expense.budget = budget

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
    params.require(:expense).permit(:description, :amount, :category, :expense_date)
  end
end
