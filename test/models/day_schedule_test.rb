require "test_helper"

class DayScheduleTest < ActiveSupport::TestCase
  test "should save day schedule" do
    day_schedule = new_day_schedule
    assert(day_schedule.save)
  end

  test "should get day" do
    day_schedule = new_day_schedule
    assert_equal(day_1.name, day_schedule.day_name)
  end

  test "should get correct start_at according timezone" do
    day_schedule = new_day_schedule
    assert_equal(starts_at, day_schedule.starts_at)
  end

  test "should get full string range" do
    day_schedule = new_day_schedule
    assert_equal("#{day_1.name} 19:00 - 00:00", day_schedule.to_s)
  end

  def day_schedule_hash
    {
      week_schedule: week_schedules(:one_cl_week_schedule),
      day: day_1,
      starts_at: starts_at,
      ends_at:  starts_at + 5.hour
    }
  end

  # Es necesario usar Time.zone para que la zona horaria del objeto Time creado coincida con la zona horaria
  # de la aplicación Rails. Si la zona horaria no coincide, entonces Rails lo va a convertir a su zona horaria
  # y la fecha que se pasa no va coincidar con la fecha que Rails guarda.
  # Otra alternativa también es pasarle  un string "2020-03-02 19:00:00" con lo cual Rails va a setear correctamente
  # el valor.
  def starts_at = Time.zone.parse("2020-03-02 19:00:00")

  def new_day_schedule
    DaySchedule.new(day_schedule_hash)
  end
end
