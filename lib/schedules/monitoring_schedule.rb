class MonitoringSchedule
  private attr_accessor :contract_schedule, :employee_availability_schedule
  private attr_writer :assignments

  def initialize(contract_schedule, employee_availability_schedule)
    self.contract_schedule = contract_schedule
    self.employee_availability_schedule = employee_availability_schedule
    self.assignments = []
  end

  def assignments
    assigntments_schedules_set
  end

  private

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
