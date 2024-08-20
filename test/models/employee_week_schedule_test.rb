require "test_helper"

class EmployeeWeekScheduleTest < ActiveSupport::TestCase
  test "should save week schedule" do
    week_schedule = new_week_schedule
    assert(week_schedule.save)
  end

  test "should set one day schedule" do
    week_schedule = new_week_schedule
    week_schedule.set_day_schedule(day_1, "19:00", "00:00")

    assert_equal("#{employee_3.name} - #{week_schedule_title}\n- #{day_1.name} 19:00 - 00:00", week_schedule.to_s)
  end

  test "should set two day schedule" do
    week_schedule = new_week_schedule
    week_schedule.set_day_schedule(day_2, "19:00", "00:00")
    week_schedule.set_day_schedule(day_7, "10:00", "00:00")
    assert_equal("#{employee_3.name} - #{week_schedule_title}\n- #{day_2.name} 19:00 - 00:00\n- #{day_7.name} 10:00 - 00:00", week_schedule.to_s)
  end

  test "should get one day schedule" do
    week_schedule = new_week_schedule
    week_schedule.set_day_schedule(day_1, "19:00", "00:00")
    assert_equal("#{day_1.name} 19:00 - 00:00", week_schedule.get_day_schedule(day_1).to_s)
  end

  test "should get employee" do
    week_schedule = new_week_schedule
    assert_equal(employee_3, week_schedule.employee)
  end

  test "should build schedule from hash" do
    week_schedule = EmployeeWeekSchedule.build_from_hash(employee_3, week_number, year, employee_week_schedule_hash)
    assert_equal("#{day_1.name} 19:00 - 00:00", week_schedule.get_day_schedule(day_1).to_s)
  end

  test "should save schedule from hash" do
    week_schedule = EmployeeWeekSchedule.build_from_hash(employee_3, week_number, year, employee_week_schedule_hash)
    assert(week_schedule.save)
    assert_equal(week_number, week_schedule.week_number)
    assert_equal(year, week_schedule.year)
    assert_equal(employee_3, week_schedule.employee)
    assert_equal(employee_week_schedule_hash.size, week_schedule.day_schedules.size)
  end

  def week_schedule_hash
    {
      week_number: week_number,
      year: year,
      employee: employee_3
    }
  end

  def new_week_schedule
    EmployeeWeekSchedule.new(week_schedule_hash)
  end

  def employee_week_schedule_hash
    employees_week_schedules_hash.group_by{ |shift| shift[:employee] }[employee_3]
  end
end
