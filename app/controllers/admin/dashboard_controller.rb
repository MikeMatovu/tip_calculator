class Admin::DashboardController < ApplicationController
  before_action :authenticate
  def index
     @tips = Tip.order(created_at: :desc)
  end

  private
  def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == "admin" && password == "admin123"
      end
    end
end
