require "utils/date_time_utils"
##
# Clase que define la estructura de un horario semanal.
#
# Instanciar un horario semanal.
#
# - @param [Integer] week_number El numero de semana al que corresponde el horario.
# - @param [Integer] year El año.
#
# Ejemplo
#   WeekSchedule.new(10, 2020)
#   # => #<WeekSchedule>

class WeekSchedule < ApplicationRecord
  belongs_to :owner, polymorphic: true
  has_many :day_schedules, dependent: :destroy

  private attr_accessor :schedule

  after_initialize :intialize_schedule

  # Agrega el horario de un dia en particular al calendario
  #
  # @param [Day] day El objeto día. Ej.: #<Day>
  # @param [String] start_time La hora de inicio. Ej.: "19:00"
  # @param [String] end_time La hora de fin. Ej.: "00:00"
  #
  # Ejemplo
  #   week_schedule.set_day_schedule(#<Day>, "19:00", "00:00")
  def set_day_schedule(day, start_time, end_time)
    day_name = day.name
    starts_at = DateTimeUtils.build_time(week_number, year, day_name, start_time)
    ends_at = DateTimeUtils.build_time(week_number, year, day_name, end_time)
    # Cuando end_time es 00:00 es necesario agregarle un día para que el final del día day_name sea el inicio del
    # siguiente día, si no se hace este cambio entonces ends_at no tendrá la fecha correcta en este caso haciendo que
    # sea menor o igual a starts_at
    ends_at += 1.day if end_time == "00:00"
    day_schedule = DaySchedule.new(day: day, starts_at: starts_at, ends_at: ends_at)
    self.day_schedules << day_schedule
    self.schedule[day.id] = day_schedule # Guarda el valor en un hash para un acceso rápido
  end

  def get_day_schedule(day)
    # Alternativa menos eficiente con potencial de O(n)
    # self.day_schedules.detect { |ds| ds.day_id = day.id }
    schedule[day.id]
  end

  def title
    "Semana #{week_number} - #{year}"
  end

  def to_s
    day_schedule_list = self.day_schedules.map { |day_schedule| "- #{day_schedule}" }.join("\n")
    "#{title}\n#{day_schedule_list}"
  end

  class << self
    def build_from_hash(owner, week_number, year, schedule_hash)
      week_schedule = self.new(
        week_number: week_number,
        year: year,
        owner: owner
      )
      return week_schedule unless schedule_hash

      schedule_hash.each do |day_schedule|
        week_schedule.set_day_schedule(day_schedule[:day], day_schedule[:start_time], day_schedule[:end_time])
      end

      week_schedule
    end
  end

  private

  def intialize_schedule
    # Se usa la variable schedule para tener un hash en memoria para encontrar rápidamente elementos usando day_id
    self.schedule = self.day_schedules.index_by(&:day_id)
  end
end
