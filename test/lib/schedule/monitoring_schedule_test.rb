require "test_helper"
require "schedule/client_week_schedule"
require "schedule/employee_week_schedule"
require "schedule/monitoring_schedule"

class MonitoringScheduleTest < ActiveSupport::TestCase
  test "build schedule" do
    monitoring_schedule = MonitoringSchedule.new(10, 2020, client, client_week_schedule_hash, employees_week_schedules_hash).build
    assert_equal("", monitoring_schedule.to_s)
  end

  def monitoring_schedule_hash
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
