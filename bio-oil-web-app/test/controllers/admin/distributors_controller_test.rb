require "test_helper"

class Admin::DistributorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:admin_user)
    @distributor = distributors(:one)
  end

  test "should get index" do
    get admin_distributors_url
    assert_response :success
  end

  test "should get show" do
    get admin_distributor_url(@distributor)
    assert_response :success
  end

  test "should get new" do
    get new_admin_distributor_url
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_distributor_url(@distributor)
    assert_response :success
  end
end
