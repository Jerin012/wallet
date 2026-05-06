class DashboardController < ApplicationController
  def index
    @budget   = Budget.first
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
    @budget   = Budget.first
  end

  def savings
    @budget = Budget.first
    @year   = Date.today.year
    @monthly_data = (1..12).map do |m|
      start = Date.new(@year, m, 1)
      spent = Expense.where(expense_date: start..start.end_of_month).sum(:amount)
      { month: start.strftime("%b"), spent: spent,
        saved: @budget ? (@budget.amount - spent) : nil }
    end
  end
end
