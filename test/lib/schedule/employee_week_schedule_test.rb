require "test_helper"
require "schedule/employee_week_schedule"
class EmployeeWeekScheduleTest < ActiveSupport::TestCase
  test "Should set one day schedule" do
    employee_week_schedule = EmployeeWeekSchedule.new("Benjamín", 10, 2020)
    employee_week_schedule.set_day_schedule("Monday", "19:00", "00:00")
    assert_equal("Benjamín - Semana 10 2020\n- Monday 19:00 - 00:00", employee_week_schedule.to_s)
  end

  test "Should set two day schedule" do
    employee_week_schedule = EmployeeWeekSchedule.new("Ernesto", 10, 2020)
    employee_week_schedule.set_day_schedule("Tuesday", "19:00", "00:00")
    employee_week_schedule.set_day_schedule("Saturday", "10:00", "15:00")
    assert_equal("Ernesto - Semana 10 2020\n- Tuesday 19:00 - 00:00\n- Saturday 10:00 - 15:00", employee_week_schedule.to_s)
  end

  test "Should get one day schedule" do
    day = "Monday"
    employee_week_schedule = EmployeeWeekSchedule.new("Benjamín", 10, 2020)
    employee_week_schedule.set_day_schedule(day, "19:00", "00:00")
    assert_equal("Monday 19:00 - 00:00", employee_week_schedule.get_day_schedule(day).to_s)
  end
end
