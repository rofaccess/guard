require "test_helper"

class ClientWeekScheduleTest < ActiveSupport::TestCase
  test "should save week schedule" do
    week_schedule = new_week_schedule
    assert(week_schedule.save)
  end

  test "should set one day schedule" do
    week_schedule = new_week_schedule
    week_schedule.set_day_schedule(day_1, "19:00", "00:00")
    assert_equal("#{client_1.name} - #{week_schedule_title}\n- #{day_1.name} 19:00 - 00:00", week_schedule.to_s)
  end

  test "should set two day schedule" do
    week_schedule = new_week_schedule
    week_schedule.set_day_schedule(day_2, "19:00", "00:00")
    week_schedule.set_day_schedule(day_6, "10:00", "00:00")
    assert_equal("#{client_1.name} - #{week_schedule_title}\n- #{day_2.name} 19:00 - 00:00\n- #{day_6.name} 10:00 - 00:00", week_schedule.to_s)
  end

  test "should get one day schedule" do
    week_schedule = new_week_schedule
    week_schedule.set_day_schedule(day_1, "19:00", "00:00")
    assert_equal("#{day_1.name} 19:00 - 00:00", week_schedule.get_day_schedule(day_1).to_s)
  end

  test "should get client" do
    week_schedule = new_week_schedule
    assert_equal(client_1, week_schedule.client)
  end

  test "should build schedule from hash" do
    week_schedule = ClientWeekSchedule.build_from_hash(client_1, week_number, year, client_week_schedule_hash)
    assert_equal("#{day_7.name} 10:00 - 00:00", week_schedule.get_day_schedule(day_7).to_s)
  end

  test "should save schedule from hash" do
    week_schedule = ClientWeekSchedule.build_from_hash(client_1, week_number, year, client_week_schedule_hash)
    assert(week_schedule.save)
    assert_equal(week_number, week_schedule.week_number)
    assert_equal(year, week_schedule.year)
    assert_equal(client_1, week_schedule.client)
    assert_equal(client_week_schedule_hash.size, week_schedule.day_schedules.size)
  end

  def week_schedule_hash
    {
      week_number: week_number,
      year: year,
      client: client_1
    }
  end

  def new_week_schedule = ClientWeekSchedule.new(week_schedule_hash)
end
