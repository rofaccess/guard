require "schedule/week_schedule"
require "utils/week_schedule_utils"
##
# Clase que define la estructura de un horario semanal de un empleado.
class EmployeeWeekSchedule
  include WeekScheduleUtils

  attr_accessor :employee, :week_schedule
  def initialize(employee, week_number, year)
    self.employee = employee
    self.week_schedule = WeekSchedule.new(week_number, year)
  end

  def to_s
    "#{employee} - #{week_schedule}"
  end

  class << self
    def build_from_hash(employee, week_number, year, day_schedules_hash)
      employee_week_schedule = EmployeeWeekSchedule.new(employee, week_number, year)

      day_schedules_hash.each do |day_schedule|
        employee_week_schedule.set_day_schedule(day_schedule[:day_name], day_schedule[:start_time], day_schedule[:end_time])
      end

      employee_week_schedule
    end
  end
end
