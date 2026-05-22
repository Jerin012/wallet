class BudgetsController < ApplicationController
  def new
    @budget = Budget.new
  end

  def create
    @budget = Budget.find_or_initialize_by(month: budget_month_label)
    @budget.assign_attributes(budget_params)
    if @budget.save
      redirect_to root_path(month: budget_month_value), notice: "Budget set successfully!"
    else
      render :new
    end
  end

  def edit
    @budget = Budget.find_by(month: budget_month_label)
  end

  def update
    @budget = Budget.find_or_initialize_by(month: budget_month_label)
    if @budget.update(budget_params)
      redirect_to root_path(month: budget_month_value), notice: "Budget updated successfully!"
    else
      render :edit
    end
  end

  private

  def budget_params
    params.require(:budget).permit(:amount)
  end

  def budget_month_value
    params.dig(:budget, :month).presence || Date.today.strftime("%Y-%m")
  end

  def budget_month_label
    Date.strptime("#{budget_month_value}-01", "%Y-%m-%d").strftime("%B %Y")
  rescue ArgumentError
    Date.today.strftime("%B %Y")
  end
end
