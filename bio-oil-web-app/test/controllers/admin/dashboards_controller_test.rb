require "test_helper"

class Admin::DashboardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:admin_user)
  end

  test "should get index" do
    get admin_root_url
    assert_response :success
  end
end
