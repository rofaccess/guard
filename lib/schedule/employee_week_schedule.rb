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
end
