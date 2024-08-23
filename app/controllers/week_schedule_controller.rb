class WeekScheduleController < ApplicationController
  WEEK_NUMBER = 10
  YEAR = 2020
  def edit
    client = Client.find_by(name: "Recorrido.cl")
    @employee = Employee.find(params[:id])
    monitoring_schedule = MonitoringSchedule.new(WEEK_NUMBER, YEAR, client, client_day_schedules(client), employees_day_schedules(@employee))
    monitoring_schedule.build
    @schedule = monitoring_schedule.schedule.to_json
    @employee_colors = Employee.pluck(:name, :color_class).to_h.to_json
  end

  def client_day_schedules(client)
    ClientWeekSchedule.get(WEEK_NUMBER, YEAR, client)
  end

  def employees_day_schedules(employee)
    EmployeeWeekSchedule.get(WEEK_NUMBER, YEAR, employee)
  end
end
