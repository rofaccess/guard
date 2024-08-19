require "utils/date_time_utils"
require "schedule/day_schedule"
class WeekSchedule
  attr_accessor :week_number, :year
  private attr_accessor :schedule

  def initialize(week_number, year)
    self.week_number = week_number
    self.year = year
    self.schedule = {}
  end

  def set_day_schedule(day_name, start_time, end_time)
    starts_at = DateTimeUtils.build_time(week_number, year, day_name, start_time)
    ends_at = DateTimeUtils.build_time(week_number, year, day_name, end_time)
    # Cuando end_time es 00:00 es necesario agregarle un día para que el final del día day_name sea el inicio del
    # siguiente día, si no se hace este cambio entonces ends_at no tendrá la fecha correcta en este caso haciendo que
    # sea menor o igual a starts_at
    ends_at += 1.day if end_time == "00:00"
    self.schedule[day_name] = DaySchedule.new(starts_at, ends_at)
  end

  def to_s
    self.schedule.map { |day_name, schedule| "#{day_name}: #{schedule}" }.join("\n")
  end
end
