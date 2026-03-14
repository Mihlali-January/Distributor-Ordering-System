require "test_helper"

class Admin::DistributorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_distributors_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_distributors_show_url
    assert_response :success
  end

  test "should get new" do
    get admin_distributors_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_distributors_edit_url
    assert_response :success
  end
end
