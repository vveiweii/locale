require "test_helper"

class BizdashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bizdashboard_index_url
    assert_response :success
  end
end
