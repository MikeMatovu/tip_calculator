require "rails_helper"

RSpec.describe TipsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user, scope: :user
  end

  xdescribe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  xdescribe "POST #create" do
    let(:valid_attributes) { FactoryBot.attributes_for(:tip, bill: 100, tip_percentage: 10, number_of_people: 2) }
    let(:invalid_attributes) { FactoryBot.attributes_for(:tip, bill: -100, tip_percentage: 10, number_of_people: 2) }

    it "creates a new tip with valid attributes" do
      expect {
        post :create, params: { tip: valid_attributes }
      }.to change(Tip, :count).by(1)
      expect(response).to have_http_status(:success)
    end

    it "does not create a tip with invalid attributes" do
      post :create, params: { tip: invalid_attributes }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
