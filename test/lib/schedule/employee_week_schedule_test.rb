require "test_helper"
require "schedule/employee_week_schedule"
class EmployeeWeekScheduleTest < ActiveSupport::TestCase
  test "Should set one day schedule" do
    employee_week_schedule = new_employee_week_schedule(employee_3)
    employee_week_schedule.set_day_schedule("Monday", "19:00", "00:00")
    assert_equal("Benjamín - Semana 10 2020\n- Monday 19:00 - 00:00", employee_week_schedule.to_s)
  end

  test "Should set two day schedule" do
    employee_week_schedule = new_employee_week_schedule(employee_1)
    employee_week_schedule.set_day_schedule("Tuesday", "19:00", "00:00")
    employee_week_schedule.set_day_schedule("Saturday", "10:00", "15:00")
    assert_equal("Ernesto - Semana 10 2020\n- Tuesday 19:00 - 00:00\n- Saturday 10:00 - 15:00", employee_week_schedule.to_s)
  end

  test "Should get one day schedule" do
    day = "Monday"
    employee_week_schedule = new_employee_week_schedule(employee_3)
    employee_week_schedule.set_day_schedule(day, "19:00", "00:00")
    assert_equal("Monday 19:00 - 00:00", employee_week_schedule.get_day_schedule(day).to_s)
  end

  test "Should get employee" do
    employee_week_schedule = new_employee_week_schedule(employee_3)
    assert_equal(employee_3, employee_week_schedule.employee)
  end

  test "Should build schedule from hash" do
    employee_day_schedules_hash = employees_week_schedules_hash.group_by{ |shift| shift[:employee] }[employee_3]
    employee_week_schedule = EmployeeWeekSchedule.build_from_hash(employee_3, 10, 2020, employee_day_schedules_hash)
    assert_equal("Monday 19:00 - 00:00", employee_week_schedule.get_day_schedule("Monday").to_s)
  end

  def new_employee_week_schedule(employee)
    EmployeeWeekSchedule.new(employee, 10, 2020)
  end
end
