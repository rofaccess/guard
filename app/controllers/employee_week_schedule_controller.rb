class EmployeeWeekScheduleController < ApplicationController
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
    #@days = Day.all
    @days = Day.all.pluck(:id, :name).to_h
  end

  def update
    @employee_week_schedule = EmployeeWeekSchedule.find(params[:id])
    if @employee_week_schedule.update(employee_week_schedule_params)
      @employee = Employee.find(params[:employee_week_schedule][:owner_id])
      redirect_to edit_employee_week_schedule_path(@employee), notice: "Disponibilidad actualizada"
    else
      render :edit
    end
  end

  def employee_week_schedule_params
    params.require(:employee_week_schedule).permit(:owner_id, day_schedules_attributes: [ :id, :day_id, :starts_at, :ends_at, :_destroy ])
  end
end
