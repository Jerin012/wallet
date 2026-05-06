require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dashboard_index_url
    assert_response :success
  end

  test "should get daily" do
    get dashboard_daily_url
    assert_response :success
  end

  test "should get monthly" do
    get dashboard_monthly_url
    assert_response :success
  end

  test "should get savings" do
    get dashboard_savings_url
    assert_response :success
  end
end
