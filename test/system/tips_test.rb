require "application_system_test_case"

class TipsTest < ApplicationSystemTestCase
  setup do
    @valid_bill = 10000
    @valid_tip_percentage = 10
    @valid_number_of_people = 2
  end

  test "submitting the form with valid inputs" do
    visit root_path

    fill_in "bill", with: @valid_bill
    fill_in "custom-tip", with: @valid_tip_percentage
    fill_in "number_of_people", with: @valid_number_of_people

    click_on "CALCULATE"

    sleep 10
    puts "Waiting for the asynchronous request to complete..."

    # Wait for the asynchronous request to complete
    assert_selector "#tip-amount", text: "0.00", wait: 10
    assert_selector "#total", text: "0.00", wait: 10

    # Log message after waiting
    puts "Asynchronous request completed."
  end

  test "submitting the form with empty fields" do
    visit root_path

    fill_in "bill", with: ""
    fill_in "custom-tip", with: ""
    fill_in "number_of_people", with: ""

    click_on "CALCULATE"

    assert_text "! Can't be zero"
    assert_text "! Can't be zero"
    assert_text "! Can't be zero"
  end

  test "submitting the form with negative values" do
    visit root_path

    fill_in "bill", with: -100
    fill_in "custom-tip", with: -10
    fill_in "number_of_people", with: -2

    click_on "CALCULATE"

    assert_text "! Can't be zero"
    assert_text "! Can't be zero"
    assert_text "! Can't be zero"
  end

  test "submitting the form with zero values" do
    visit root_path

    fill_in "bill", with: 0
    fill_in "custom-tip", with: 0
    fill_in "number_of_people", with: 0

    click_on "CALCULATE"

    assert_text "! Can't be zero"
    assert_text "! Can't be zero"
    assert_text "! Can't be zero"
  end
end
