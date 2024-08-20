require "utils/day_utils"

# Clase de utilería que agrupa métodos relacionados con el manejo de fecha y horas.
class DateTimeUtils
  class << self
    # Return a date object.
    # > DateTimeUtils.build_date(10, 2020, "Monday", "19:00")
    #   => 2020-03-02
    def build_date(week_number, year, day_name)
      day_number = DayUtils.day_number(day_name)
      Date.commercial(year, week_number, day_number)
    end

    # Return a time object.
    # > DateTimeUtils.build_time(10, 2020, "Monday", "19:00")
    #   =>
    def build_time(week_number, year, day_name, time)
      date = build_date(week_number, year, day_name)
      Time.zone.parse("#{date} #{time}")
    end
  end
end
