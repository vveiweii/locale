require "test_helper"

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get line_items_create_url
    assert_response :success
  end

  test "should get add_quantity" do
    get line_items_add_quantity_url
    assert_response :success
  end

  test "should get reduce_quantity" do
    get line_items_reduce_quantity_url
    assert_response :success
  end

  test "should get destroy" do
    get line_items_destroy_url
    assert_response :success
  end
end
