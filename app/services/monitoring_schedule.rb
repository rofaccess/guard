class MonitoringSchedule
  private attr_accessor :week_number, :year, :client, :schedule

  def initialize(week_number, year, client)
    self.week_number = week_number
    self.year = year
    self.client = client
    self.schedule = {}
  end

  def build

  end

  private

  def client_day_schedules
    @client_days_schedules ||=
      ClientWeekSchedule.includes(:day_schedules).where(week_number: week_number, year: year, owner_id: client.id)
  end

  def employees_week_schedules
    @employees_week_schedules ||=
      EmployeeWeekSchedule.includes(:day_schedules).where(week_number: week_number, year: year).index_by(&:owner_id)
  end

  def employees_day_schedules
    @employees_day_schedules_by_day ||=
      DaySchedule.joins(:week_schedule, :day)
                 .joins("inner join employees on employees.id = week_schedules.owner_id")
                 .where(week_schedules: { type: "EmployeeWeekSchedule", week_number: week_number, year: year })
                 .select("day_schedules.*, week_schedules.owner_id as employee_id, days.name as day_name")
                 .order("days.order, employees.created_at")
                 .group_by(&:day_name)
  end
end
