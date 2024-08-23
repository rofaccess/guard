class HomeController < ApplicationController
  def index
    client = Client.find_by(name: "Recorrido.cl")
    monitoring_schedule = MonitoringSchedule.new(10, 2020, client)
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
end
