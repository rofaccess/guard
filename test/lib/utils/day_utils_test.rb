require "test_helper"
require "utils/day_utils"
class DayUtilsTest < ActiveSupport::TestCase
  test "Should get number 1 for Monday" do
    assert_equal(1, DayUtils.day_number("Monday"))
  end

  test "Should get number 2 for Monday" do
    assert_equal(2, DayUtils.day_number("Tuesday"))
  end

  test "Should get number 3 for Monday" do
    assert_equal(3, DayUtils.day_number("Wednesday"))
  end

  test "Should get number 4 for Monday" do
    assert_equal(4, DayUtils.day_number("Thursday"))
  end

  test "Should get number 5 for Monday" do
    assert_equal(5, DayUtils.day_number("Friday"))
  end

  test "Should get number 6 for Monday" do
    assert_equal(6, DayUtils.day_number("Saturday"))
  end

  test "Should get number 7 for Sunday" do
    assert_equal(7, DayUtils.day_number("Sunday"))
  end
end
