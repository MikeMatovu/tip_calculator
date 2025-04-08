require "rails_helper"

RSpec.describe Admin::DashboardController, type: :controller do
  let(:admin_user) { FactoryBot.create(:user, :admin) }

  before do
    sign_in admin_user, scope: :user
  end

  xdescribe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
