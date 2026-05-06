class BudgetsController < ApplicationController
  def new
    @budget = Budget.new
  end

  def create
    @budget = Budget.new(budget_params)
    if @budget.save
      redirect_to root_path, notice: "Budget set successfully!"
    else
      render :new
    end
  end

  def edit
    @budget = Budget.first
  end

  def update
    @budget = Budget.first
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