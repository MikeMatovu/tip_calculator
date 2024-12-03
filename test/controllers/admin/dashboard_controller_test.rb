require "test_helper"

class Admin::DashboardControllerTest < ActionDispatch::IntegrationTest
  setup do
    @username = ENV["ADMIN_USERNAME"] || "admin"
    @password = ENV["ADMIN_PASSWORD"] || "admin123"
  end

  test "should get index" do
    get admin_dashboard_index_url, headers: { "HTTP_AUTHORIZATION" => basic_auth(@username, @password) }
    assert_response :success
  end

  private

  def basic_auth(username, password)
    ActionController::HttpAuthentication::Basic.encode_credentials(username, password)
  end
end