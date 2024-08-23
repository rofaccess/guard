class HomeController < ApplicationController
  WEEK_NUMBER = 10
  YEAR = 2020
  def index
    client = Client.find_by(name: "Recorrido.cl")
    monitoring_schedule = MonitoringSchedule.new(WEEK_NUMBER, YEAR, client, client_day_schedules(client), employees_day_schedules)
    monitoring_schedule.build
    @schedule = monitoring_schedule.schedule.to_json
    @summary = summary(monitoring_schedule)
    @employees = Employee.pluck(:id, :name).to_h.to_json
    @employee_colors = Employee.pluck(:name, :color_class).to_h.to_json
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

  def client_day_schedules(client)
    ClientWeekSchedule.get(WEEK_NUMBER, YEAR, client)
  end

  def employees_day_schedules
    EmployeeWeekSchedule.get(WEEK_NUMBER, YEAR)
  end
end
