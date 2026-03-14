require "test_helper"

class Admin::SkusControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:admin_user)
    @distributor = distributors(:one)
    @sku = skus(:one)
  end

  test "should get index" do
    get admin_distributor_skus_url(@distributor)
    assert_response :success
  end

  test "should get new" do
    get new_admin_distributor_sku_url(@distributor)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_distributor_sku_url(@distributor, @sku)
    assert_response :success
  end
end
