class HomeController < ApplicationController
  def index
    client = Client.find_by(name: "Recorrido.cl")
    monitoring_schedule = MonitoringSchedule.new(10, 2020, client)
    monitoring_schedule.build
    @schedule = monitoring_schedule.schedule
    @schedule_hours = monitoring_schedule.schedule_hours
  end
end
