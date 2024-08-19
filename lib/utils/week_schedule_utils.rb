module WeekScheduleUtils
  def set_day_schedule(day_name, start_time, end_time)
    week_schedule.set_day_schedule(day_name, start_time, end_time)
  end

  def get_day_schedule(day_name)
    week_schedule.get_day_schedule(day_name)
  end
end
