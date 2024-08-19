require "test_helper"
require "schedule/client_week_schedule"
class ClientWeekScheduleTest < ActiveSupport::TestCase
  test "Should set one day schedule" do
    client_week_schedule = ClientWeekSchedule.new("Recorrido.cl", 10, 2020)
    client_week_schedule.set_day_schedule("Monday", "19:00", "00:00")
    assert_equal("Recorrido.cl - Semana 10 2020\n- Monday 19:00 - 00:00", client_week_schedule.to_s)
  end

  test "Should set two day schedule" do
    client_week_schedule = ClientWeekSchedule.new("Recorrido.cl", 10, 2020)
    client_week_schedule.set_day_schedule("Tuesday", "19:00", "00:00")
    client_week_schedule.set_day_schedule("Saturday", "10:00", "00:00")
    assert_equal("Recorrido.cl - Semana 10 2020\n- Tuesday 19:00 - 00:00\n- Saturday 10:00 - 00:00", client_week_schedule.to_s)
  end

  test "Should get one day schedule" do
    day = "Monday"
    client_week_schedule = ClientWeekSchedule.new("Benjamín", 10, 2020)
    client_week_schedule.set_day_schedule(day, "19:00", "00:00")
    assert_equal("Monday 19:00 - 00:00", client_week_schedule.get_day_schedule(day).to_s)
  end
end
