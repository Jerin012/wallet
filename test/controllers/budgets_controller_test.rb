require "test_helper"

class BudgetsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_budget_url
    assert_response :success
  end

  test "should create budget for selected month" do
    assert_difference("Budget.count", 1) do
      post budget_url, params: { budget: { amount: 5000, month: "2026-04" } }
    end

    assert_redirected_to root_url(month: "2026-04")
    assert_equal "April 2026", Budget.order(:created_at).last.month
  end

  test "should get edit" do
    Budget.create!(amount: 4000, month: Date.today.strftime("%B %Y"))
    get edit_budget_url, params: { budget: { month: Date.today.strftime("%Y-%m") } }
    assert_response :success
  end

  test "should update budget for selected month" do
    budget = Budget.create!(amount: 4000, month: "April 2026")

    patch budget_url, params: { budget: { amount: 6500, month: "2026-04" } }

    assert_redirected_to root_url(month: "2026-04")
    assert_equal 6500, budget.reload.amount.to_i
  end
end
