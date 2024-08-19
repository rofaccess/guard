require "test_helper"
require "schedule/day_schedule"

class DayScheduleTest < ActiveSupport::TestCase
  test "Should get day" do
    assert_equal("Monday", new_day_schedule.day)
  end

  test "Should get string range" do
    assert_equal("19:00 - 00:00", new_day_schedule.to_s)
  end

  def new_day_schedule
    starts_at = Time.parse("2020-03-02 19:00:00")
    ends_at = starts_at + 5.hour
    DaySchedule.new(starts_at, ends_at)
  end
end
