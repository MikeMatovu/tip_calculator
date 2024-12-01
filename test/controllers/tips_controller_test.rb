require "test_helper"

class TipsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tips_url
    assert_response :success
  end

  test "should create tip" do
    assert_difference("Tip.count") do
      post tips_url, params: { tip: { bill: 100, tip_percentage: 10, number_of_people: 2 } }
    end
    assert_response :success
  end

  test "should not create tip with invalid data" do
    post tips_url, params: { tip: { bill: -100, tip_percentage: 10, number_of_people: 2 } }
    assert_response :unprocessable_entity
  end
end
