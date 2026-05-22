class ExpensesController < ApplicationController
  def new
    @expense = Expense.new
  end

  def create
    expense_date = expense_params[:expense_date].present? ? Date.parse(expense_params[:expense_date]) : Date.today
    expense_month = expense_date.strftime("%B %Y")
    budget = Budget.find_by(month: expense_month)
    if budget.nil?
      redirect_to root_path(month: expense_date.strftime("%Y-%m")), alert: "Set budget first for #{expense_month}"
      return
    end
    @expense = Expense.new(expense_params)
    @expense.month = expense_month
    @expense.budget = budget

    if @expense.save
      redirect_to root_path(month: expense_date.strftime("%Y-%m")), notice: "Expense added successfully!"
    else
      redirect_to root_path(month: expense_date.strftime("%Y-%m")), alert: "Failed to add expense."
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
