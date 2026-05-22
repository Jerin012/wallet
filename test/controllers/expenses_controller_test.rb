require "test_helper"

class ExpensesControllerTest < ActionDispatch::IntegrationTest
  test "should create expense for previous month budget" do
    budget = Budget.create!(amount: 10000, month: "April 2026")

    assert_difference("Expense.count", 1) do
      post expenses_url, params: {
        expense: {
          description: "Rent",
          amount: 2500,
          category: "other",
          expense_date: "2026-04-12"
        }
      }
    end

    expense = Expense.order(:created_at).last
    assert_redirected_to root_url(month: "2026-04")
    assert_equal "April 2026", expense.month
    assert_equal budget.id, expense.budget_id
  end

  test "should require budget for expense month" do
    assert_no_difference("Expense.count") do
      post expenses_url, params: {
        expense: {
          description: "Trip",
          amount: 1200,
          category: "transport",
          expense_date: "2026-03-10"
        }
      }
    end

    assert_redirected_to root_url(month: "2026-03")
  end

  test "should destroy expense" do
    budget = Budget.create!(amount: 10000, month: "April 2026")
    expense = Expense.create!(
      description: "Rent",
      amount: 2500,
      category: "other",
      expense_date: Date.new(2026, 4, 12),
      month: "April 2026",
      budget: budget
    )

    assert_difference("Expense.count", -1) do
      delete expense_url(expense)
    end

    assert_redirected_to root_url
  end
end
