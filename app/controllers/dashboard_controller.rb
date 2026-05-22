class DashboardController < ApplicationController
  def index
    @selected_month = parse_month(params[:month]) || Date.today.beginning_of_month
    @budget = Budget.find_by(month: month_label(@selected_month))
    @expenses = Expense.where(expense_date: @selected_month.beginning_of_month..@selected_month.end_of_month)
                       .order(expense_date: :desc)
                       .limit(10)
  end

  def daily
    @date     = params[:date] ? Date.parse(params[:date]) : Date.today
    @expenses = Expense.where(expense_date: @date)
    @total    = @expenses.sum(:amount)
  end

  def monthly
    @month    = parse_month(params[:month]) || Date.today.beginning_of_month
    @expenses = Expense.where(expense_date: @month.beginning_of_month..@month.end_of_month)
    @by_cat   = @expenses.group(:category).sum(:amount)
    @budget = Budget.find_by(month: month_label(@month))
  end

  def savings
    @year = Date.today.year

    @monthly_data = (1..12).map do |m|
      start = Date.new(@year, m, 1)
      spent = Expense.where(expense_date: start..start.end_of_month).sum(:amount)
      budget = Budget.find_by(month: month_label(start))

      {
        month: start.strftime("%b"),
        spent: spent,
        budget: budget ? budget.amount : 0,
        saved: budget ? (budget.amount - spent) : 0
      }
    end
  end

  private

  def parse_month(value)
    return if value.blank?

    Date.strptime("#{value}-01", "%Y-%m-%d").beginning_of_month
  rescue ArgumentError
    nil
  end

  def month_label(date)
    date.strftime("%B %Y")
  end
end
