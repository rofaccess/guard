class HomeController < ApplicationController
  include WeekScheduleConcern
  def index
    client = Client.find_by(name: "Recorrido.cl")
    monitoring_schedule = MonitoringSchedule.new(WEEK_NUMBER, YEAR, client, client_day_schedules(client), employees_day_schedules)
    monitoring_schedule.build
    @schedule = monitoring_schedule.schedule.to_json
    @summary = summary(monitoring_schedule)
    @employees = Employee.pluck(:id, :name).to_h.to_json
    @employee_colors = Employee.pluck(:name, :color_class).to_h.to_json
  end
end
