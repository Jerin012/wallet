class BudgetsController < ApplicationController
  def new
    @budget = Budget.new
  end

  def create
    @budget = Budget.new(budget_params)
    @budget.month = Date.today.strftime("%B %Y")
    if @budget.save
      redirect_to root_path, notice: "Budget set successfully!"
    else
      render :new
    end
  end

  def edit
    @budget = Budget.find_by(month: Date.today.strftime("%B %Y"))
  end

  def update
    @budget = Budget.find_by(month: Date.today.strftime("%B %Y"))
    if @budget.update(budget_params)
      redirect_to root_path, notice: "Budget updated successfully!"
    else
      render :edit
    end
  end

  private

  def budget_params
    params.require(:budget).permit(:amount)
  end
end
