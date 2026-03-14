require "test_helper"

class Admin::SkusControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_skus_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_skus_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_skus_edit_url
    assert_response :success
  end
end
