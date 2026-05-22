require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should get index for selected month" do
    get root_url, params: { month: "2026-04" }
    assert_response :success
  end

  test "should get daily" do
    get daily_url
    assert_response :success
  end

  test "should get monthly" do
    get monthly_url, params: { month: "2026-04" }
    assert_response :success
  end

  test "should get savings" do
    get savings_url
    assert_response :success
  end
end
