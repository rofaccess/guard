require "test_helper"

class MonitoringScheduleTest < ActiveSupport::TestCase
  WEEK_NUMBER = 10
  YEAR = 2020

  test "build schedule" do
    init_data
    monitoring_schedule = MonitoringSchedule.new(WEEK_NUMBER, YEAR, client_1, client_day_schedules(client_1), employees_day_schedules)
    monitoring_schedule.build
    puts monitoring_schedule
    assert(true)
  end

  def init_data
    create_client_week_schedule
    create_employees_week_schedules
  end

  def create_client_week_schedule
    week_schedule = ClientWeekSchedule.build_from_hash(client_1, WEEK_NUMBER, YEAR, client_week_schedule_hash)
    assert(week_schedule.save)
  end

  def create_employees_week_schedules
    grouped_week_schedule_hash = employees_week_schedules_hash.group_by{ |shift| shift[:employee] }

    week_schedule = EmployeeWeekSchedule.build_from_hash(employee_1, WEEK_NUMBER, YEAR, grouped_week_schedule_hash[employee_1])
    assert(week_schedule.save)

    week_schedule = EmployeeWeekSchedule.build_from_hash(employee_2, WEEK_NUMBER, YEAR, grouped_week_schedule_hash[employee_2])
    assert(week_schedule.save)

    week_schedule = EmployeeWeekSchedule.build_from_hash(employee_3, WEEK_NUMBER, YEAR, grouped_week_schedule_hash[employee_3])
    assert(week_schedule.save)
  end

  def client_day_schedules(client)
    ClientWeekSchedule.get(WEEK_NUMBER, YEAR, client)
  end

  def employees_day_schedules
    EmployeeWeekSchedule.get(WEEK_NUMBER, YEAR)
  end

  def expected_result_hash
    {
      "Monday" => [
        { start_time: "19:00", end_time: "00:00", employee_id: "Benjamín" }
      ],
      "Tuesday" => [
        { start_time: "19:00", end_time: "00:00", employee_id: "Ernesto" }
      ],
      "Wednesday" => [
        { start_time: "19:00", end_time: "00:00", employee_id: "Benjamín" }
      ],
      "Thursday" => [
        { start_time: "19:00", end_time: "00:00", employee_id: "Ernesto" }
      ],
      "Friday" => [
        { start_time: "19:00", end_time: "00:00", employee_id: "Bárbara" }
      ],
      "Saturday" => [
        { start_time: "10:00", end_time: "15:00", employee_id: "Ernesto" },
        { start_time: "15:00", end_time: "18:00", employee_id: nil },
        { start_time: "18:00", end_time: "00:00", employee_id: "Benjamín" }
      ],
      "Sunday" => [
        { start_time: "10:00", end_time: "00:00", employee_id: "Bárbara" }
      ]
    }
  end
end
