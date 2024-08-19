require "schedule/week_schedule"
require "utils/week_schedule_utils"
##
# Clase que define la estructura de un horario semanal de un cliente establecido por contrato.
class ClientWeekSchedule
  include WeekScheduleUtils

  attr_accessor :client, :week_schedule
  def initialize(client, week_number, year)
    self.client = client
    self.week_schedule = WeekSchedule.new(week_number, year)
  end

  def to_s
    "#{client} - #{week_schedule}"
  end
end
