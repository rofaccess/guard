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
end
