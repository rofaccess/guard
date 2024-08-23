class EmployeeWeekSchedule < WeekSchedule
  alias_method :employee, :owner
  delegate :name, to: :employee, prefix: true, allow_nil: true
  def to_s
    "#{employee_name} - #{super}"
  end

  # Setter para employee.
  def employee=(employee)
    self.owner = employee
  end

  def self.get(week_number, year, employee = nil)
    query = DaySchedule.joins(:week_schedule, :day).joins("inner join employees on employees.id = week_schedules.owner_id")
    query = query.where(week_schedules: { owner_id: employee.id, owner_type: "Employee" }) if employee

    query.where(week_schedules: { type: "EmployeeWeekSchedule", week_number: week_number, year: year })
         .select("day_schedules.*, week_schedules.owner_id as employee_id, employees.name as employee_name, days.name as day_name")
         .order("days.order, employees.created_at")
         .group_by(&:day_name)
  end
end
