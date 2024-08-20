class MonitoringSchedule
  private attr_accessor :week_number, :year, :client, :schedule

  def initialize(week_number, year, client)
    self.week_number = week_number
    self.year = year
    self.client = client
    self.schedule = build_empty_schedule
  end

  def build
    Day.all.each do |day|
      day_schedules = schedule[day.name]
      employees_week_schedules.each do |_, employee_week_schedule|
        day_schedule = employee_week_schedule.get_day_schedule(day)
        next unless day_schedule

        if day_schedules.empty?
          day_schedules << day_schedule
        else
          a = 2
        end
        a = 2

      end
    end
    a = 2
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

  ##
  # Retorna un hash con los días de la semana como claves y seteando un arreglo vacío en los valores
  def build_empty_schedule
    day_names.map { |day_name| [ day_name, [] ] }.to_h
  end

  def day_names
    Day.pluck(:name)
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
