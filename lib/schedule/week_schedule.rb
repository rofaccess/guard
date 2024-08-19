require "utils/date_time_utils"
require "schedule/day_schedule"
##
# Clase que define la estructura de un horario semanal.
class WeekSchedule
  attr_accessor :week_number, :year
  private attr_accessor :schedule

  ##
  # Crea un horario semanal.
  #
  # - @param [Integer] week_number El numero de semana al que corresponde el horario.
  # - @param [Integer] year El año.
  #
  # Ejemplo
  #   WeekSchedule.new(10, 2020)
  #   # => #<WeekSchedule>
  def initialize(week_number, year)
    self.week_number = week_number
    self.year = year
    self.schedule = {}
  end

  # Agrega el horario de un dia en particular al calendario
  #
  # @param [String] day_name El nombre del día. Ej.: "Monday"
  # @param [String] start_time La hora de inicio. Ej.: "19:00"
  # @param [String] end_time La hora de fin. Ej.: "00:00"
  #
  # Ejemplo
  #   week_schedule.set_day_schedule("Monday", "19:00", "00:00")
  def set_day_schedule(day_name, start_time, end_time)
    starts_at = DateTimeUtils.build_time(week_number, year, day_name, start_time)
    ends_at = DateTimeUtils.build_time(week_number, year, day_name, end_time)
    # Cuando end_time es 00:00 es necesario agregarle un día para que el final del día day_name sea el inicio del
    # siguiente día, si no se hace este cambio entonces ends_at no tendrá la fecha correcta en este caso haciendo que
    # sea menor o igual a starts_at
    ends_at += 1.day if end_time == "00:00"
    self.schedule[day_name] = DaySchedule.new(starts_at, ends_at)
  end

  def get_day_schedule(day_name)
    schedule[day_name]
  end

  def to_s
    day_schedule_list = schedule.map { |_, schedule| "- #{schedule}" }.join("\n")
    "Semana #{week_number} #{year}\n#{day_schedule_list}"
  end
end
