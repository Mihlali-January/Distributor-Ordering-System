require "test_helper"

class Admin::ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:admin_user)
    @product = products(:one)
  end

  test "should get index" do
    get admin_products_url
    assert_response :success
  end

  test "should get show" do
    get admin_product_url(@product)
    assert_response :success
  end

  test "should get new" do
    get new_admin_product_url
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_product_url(@product)
    assert_response :success
  end
end
