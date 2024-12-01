# test/models/tip_test.rb
require "test_helper"

class TipTest < ActiveSupport::TestCase
  test "should not save tip without bill" do
    tip = Tip.new(tip_percentage: 10, number_of_people: 2)
    assert_not tip.save, "Saved the tip without a bill"
  end

  test "should not save tip with negative bill" do
    tip = Tip.new(bill: -100, tip_percentage: 10, number_of_people: 2)
    assert_not tip.save, "Saved the tip with a negative bill"
  end

  test "should save valid tip" do
    tip = Tip.new(bill: 100, tip_percentage: 10, number_of_people: 2)
    assert tip.save, "Could not save a valid tip"
  end
end


