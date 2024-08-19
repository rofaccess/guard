require "test_helper"
require "schedule/week_schedule"
class WeekScheduleTest < ActiveSupport::TestCase
  test "Should set one day schedule" do
    week_schedule = WeekSchedule.new(10, 2020)
    week_schedule.set_day_schedule("Monday", "19:00", "00:00")
    assert_equal("Monday: 19:00 - 00:00", week_schedule.to_s)
  end

  test "Should set two day schedule" do
    week_schedule = WeekSchedule.new(10, 2020)
    week_schedule.set_day_schedule("Monday", "19:00", "00:00")
    week_schedule.set_day_schedule("Saturday", "10:00", "00:00")
    assert_equal("Monday: 19:00 - 00:00\nSaturday: 10:00 - 00:00", week_schedule.to_s)
  end
end
