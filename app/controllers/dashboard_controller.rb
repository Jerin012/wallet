class DashboardController < ApplicationController
  def index
    @budget = Budget.find_by(month: Date.today.strftime("%B %Y"))
    @expenses = Expense.order(expense_date: :desc).limit(10)
  end

  def daily
    @date     = params[:date] ? Date.parse(params[:date]) : Date.today
    @expenses = Expense.where(expense_date: @date)
    @total    = @expenses.sum(:amount)
  end

  def monthly
    @month    = params[:month] ? Date.parse(params[:month] + "-01") : Date.today.beginning_of_month
    @expenses = Expense.where(expense_date: @month.beginning_of_month..@month.end_of_month)
    @by_cat   = @expenses.group(:category).sum(:amount)
    @budget = Budget.find_by(month: @month.strftime("%B %Y"))
  end

  def savings
  @year = Date.today.year

  @monthly_data = (1..12).map do |m|
    start = Date.new(@year, m, 1)

    spent = Expense.where(expense_date: start..start.end_of_month).sum(:amount)

    budget = Budget.find_by(month: start.strftime("%B %Y"))

    {
      month: start.strftime("%b"),
      spent: spent,
      budget: budget ? budget.amount : 0,
      saved: budget ? (budget.amount - spent) : 0
    }
  end
end
end
