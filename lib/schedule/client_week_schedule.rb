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

  class << self
    def build_from_hash(client, week_number, year, schedule_hash)
      client_week_schedule = ClientWeekSchedule.new(client, week_number, year)

      schedule_hash.each do |day_name, day_schedule|
        client_week_schedule.set_day_schedule(day_name, day_schedule[:start_time], day_schedule[:end_time])
      end

      client_week_schedule
    end
  end
end
