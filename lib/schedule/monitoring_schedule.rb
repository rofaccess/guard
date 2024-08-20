require "utils/day_utils"
class MonitoringSchedule
  private attr_accessor :week_number, :year, :client, :client_week_schedule, :employees_week_schedules, :schedule

  def initialize(week_number, year, client, client_week_schedule_hash, employees_week_schedules_hash)
    self.week_number = week_number
    self.year = year
    self.client = client
    self.client_week_schedule = build_client_week_schedule(client_week_schedule_hash)
    self.employees_week_schedules = build_employees_week_schedules(employees_week_schedules_hash)
    self.schedule = build_empty_schedule
  end

  def build
    DayUtils.day_names.each do |day_name|
      day_schedules = schedule[day_name]

      employees_week_schedules.each do |employee_week_schedule|
        day_schedule = employee_week_schedule.get_day_schedule(day_name)
        next unless day_schedule

        if day_schedules.empty?
          day_schedules << day_schedule
        else
          a = 2
        end
        a = 2
      end
    end
  end

  private

  def build_client_week_schedule(client_week_schedule_hash)
    ClientWeekSchedule.build_from_hash(client, week_number, year, client_week_schedule_hash)
  end

  def build_employees_week_schedules(employees_week_schedules_hash)
    employees_week_schedules = []
    employees_week_schedules_hash.group_by { |shift| shift[:employee] }.each do |employee, week_schedule|
      employee_week_schedule = EmployeeWeekSchedule.new(employee, week_number, year)

      week_schedule.each do |day_schedule|
        employee_week_schedule.set_day_schedule(day_schedule[:day_name], day_schedule[:start_time], day_schedule[:end_time])
      end

      employees_week_schedules << employee_week_schedule
    end

    employees_week_schedules
  end

  ##
  # Retorna un hash con los días de la semana como claves y seteando un arreglo vacío en los valores
  def build_empty_schedule
    DayUtils.day_names.map { |day_name| [ day_name, [] ] }.to_h
  end
  #
  def assigntments_schedules_set
    # Tengo que procesar primero los disponibilidades segun solapamientos para luego combinar
    # necesito una combinatoria de disponibilidades de cada dia?
    monday = employee_availability_schedule["Monday"]
    tuesday = employee_availability_schedule["Tuesday"]
    wednesday = employee_availability_schedule["Wednesday"]
    thursday = employee_availability_schedule["Thursday"]
    friday = employee_availability_schedule["Friday"]
    saturday = employee_availability_schedule["Saturday"]
    sunday = employee_availability_schedule["Sunday"]
    combinations = monday.product(tuesday, wednesday, thursday, friday, saturday, sunday)
    employee_availability_schedule.each do |day, employees_availables|
      a = 2
    end
    a = 2
  end
end
