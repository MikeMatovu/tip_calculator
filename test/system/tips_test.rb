require "application_system_test_case"

class TipsTest < ApplicationSystemTestCase
  setup do
    @valid_bill = 100
    @valid_tip_percentage = 10
    @valid_number_of_people = 2
  end

  test "submitting the form with valid inputs" do
    visit root_path

    fill_in "Bill ($)", with: @valid_bill
    fill_in "tip_tip_percentage", with: @valid_tip_percentage
    fill_in "Number of People", with: @valid_number_of_people

    click_on "CALCULATE"

    assert_text "Tip Amount"
    assert_text "Total"
    assert_text "Per Person"
  end

  test "submitting the form with empty fields" do
    visit root_path

    fill_in "Bill ($)", with: ""
    fill_in "tip_tip_percentage", with: ""
    fill_in "Number of People", with: ""

    click_on "CALCULATE"

    assert_text "Bill can't be blank"
    assert_text "Tip percentage can't be blank"
    assert_text "Number of people can't be blank"
  end

  test "submitting the form with negative values" do
    visit root_path

    fill_in "Bill ($)", with: -100
    fill_in "tip_tip_percentage", with: -10
    fill_in "Number of People", with: -2

    click_on "CALCULATE"

    assert_text "Bill must be greater than 0"
    assert_text "Tip percentage must be greater than or equal to 0"
    assert_text "Number of people must be greater than 0"
  end

  test "submitting the form with zero values" do
    visit root_path

    fill_in "Bill ($)", with: 0
    fill_in "tip_tip_percentage", with: 0
    fill_in "Number of People", with: 0

    click_on "CALCULATE"

    assert_text "Bill must be greater than 0"
    assert_text "Tip percentage must be greater than or equal to 0"
    assert_text "Number of people must be greater than 0"
  end
end