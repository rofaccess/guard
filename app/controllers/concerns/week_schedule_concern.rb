module WeekScheduleConcern
  extend ActiveSupport::Concern

  WEEK_NUMBER = 10
  YEAR = 2020
  def client_day_schedules(client)
    ClientWeekSchedule.get(WEEK_NUMBER, YEAR, client)
  end

  def employees_day_schedules(employee = nil)
    EmployeeWeekSchedule.get(WEEK_NUMBER, YEAR, employee)
  end

  def summary(monitoring_schedule)
    schedule_hours = monitoring_schedule.schedule_hours
    summary = {
      "Cliente" => monitoring_schedule.client_name,
      "Semana" => monitoring_schedule.week,
      "Rango" => monitoring_schedule.range
    }

    summary.merge(schedule_hours).to_json
  end
end
