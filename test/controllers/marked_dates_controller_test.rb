require "test_helper"

class MarkedDatesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    post marked_dates_url
    assert_response :success
  end

  test "should get destroy" do
    delete marked_date_url(marked_dates(:one))
    assert_response :success
  end
end
