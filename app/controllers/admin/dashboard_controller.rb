class Admin::DashboardController < ApplicationController
  def index
     @tips = Tip.order(created_at: :desc)
  end
end
