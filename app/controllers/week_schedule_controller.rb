class WeekScheduleController < ApplicationController
  include WeekScheduleConcern

  def edit
    client = Client.find_by(name: "Recorrido.cl")
    @employee = Employee.find(params[:id])
    monitoring_schedule = MonitoringSchedule.new(WEEK_NUMBER, YEAR, client, client_day_schedules(client), employees_day_schedules(@employee))
    monitoring_schedule.build
    @schedule = monitoring_schedule.schedule.to_json
    @summary = summary(monitoring_schedule)
    @employees = Employee.pluck(:id, :name).to_h.to_json
    @employee_colors = Employee.pluck(:name, :color_class).to_h.to_json
    @week_schedule = WeekSchedule.find_by(owner_id: @employee.id, owner_type: "Employee")
    a = 2
  end

  def update
    @employee = Employee.find(params[:id])
  end
end
