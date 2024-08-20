require "test_helper"

class WeekScheduleTest < ActiveSupport::TestCase
  test "should save week schedule" do
    week_schedule = new_week_schedule
    assert(week_schedule.save)
  end

  test "should set one day schedule" do
    week_schedule = new_week_schedule
    week_schedule.set_day_schedule(day_1, "19:00", "00:00")

    assert(week_schedule.save)
    assert_equal("#{week_schedule_title}\n- #{day_1.name} 19:00 - 00:00", week_schedule.to_s)
  end

  def week_schedule_hash
    {
      week_number: week_number,
      year: year,
      type: WeekSchedule,
      owner: client_1
    }
  end

  def new_week_schedule
    WeekSchedule.new(week_schedule_hash)
  end
end
