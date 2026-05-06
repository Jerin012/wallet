require "test_helper"

class MarkedDatesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get marked_dates_create_url
    assert_response :success
  end

  test "should get destroy" do
    get marked_dates_destroy_url
    assert_response :success
  end
end
