class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
     @tips = Tip.order(created_at: :desc)
  end

  private
  def authenticate
    admin_username = ENV["ADMIN_USERNAME"] || "admin"
    admin_password = ENV["ADMIN_PASSWORD"] || "admin123"
    authenticate_or_request_with_http_basic do |username, password|
      username == admin_username && password == admin_password
    end
  end
end
