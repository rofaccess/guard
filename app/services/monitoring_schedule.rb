require "utils/date_time_utils"
class MonitoringSchedule
  attr_accessor :schedule, :schedule_hours
  private attr_accessor :week_number, :year, :client, :client_day_schedules, :employees_day_schedules, :shifts,
                        :shifts_hours, :tentative_schedules, :tentative_schedules_hours

  def initialize(week_number, year, client, client_day_schedules, employees_day_schedules)
    self.week_number = week_number
    self.year = year
    self.client = client
    self.client_day_schedules = client_day_schedules
    self.employees_day_schedules = employees_day_schedules
    self.shifts = {}
    self.shifts_hours = {}
    self.tentative_schedules = []
    self.tentative_schedules_hours = {}
    self.schedule = {}
  end

  def build
    build_shifts
    build_shift_hours
    build_tentative_schedules
    build_tentative_schedules_hours
    solution, solution_index = get_optimal_solution
    selected_schedule = tentative_schedules[solution_index]
    self.schedule_hours = tentative_schedules_hours[solution_index]
    build_schedule(selected_schedule)
  end

  def to_s
    result = "Horas\n"

    schedule_hours.each do | employee, hour |
      result << "#{employee}: #{hour}\n"
    end

    schedule.each do |day_name, shifts|
      result << "#{day_name}\n"
      shifts.each do |shift|
        result << shift.join(": ")
        result << "\n"
      end
    end
    result
  end

  def client_name
    client.name
  end

  def week
    "#{week_number} del #{year}"
  end

  def range
    starts_at = DateTimeUtils.build_time(week_number, year, "Monday", "00:00")
    ends_at = DateTimeUtils.build_time(week_number, year, "Sunday", "00:00")
    "#{starts_at.strftime("%d-%m-%Y")} al #{ends_at.strftime("%d-%m-%Y")}"
  end

  private

  def build_shifts
    unallocated = "Sin Asignar"
    Day.pluck(:name).each do |day_name|
      client_day_schedule = client_day_schedules[day_name]
      next unless client_day_schedule

      time_blocks = {}

      build_time_blocks(client_day_schedule) do |time_block|
        time_blocks[time_block] = []
      end

      employees_days_schedules = employees_day_schedules[day_name]
      next unless employees_days_schedules

      employees_days_schedules.each do |employee_day_schedule|
        build_time_blocks(employee_day_schedule) do |time_block|
          time_blocks[time_block] << employee_day_schedule.employee_name if time_blocks[time_block]
        end
      end

      shift_number = 1
      shift_name = "#{day_name}-#{shift_number}"
      shifts = { shift_name => {} }

      time_blocks.each do |time_block, employees|
        if employees.size == 0
          shifts[shift_name][time_block] = unallocated
        elsif employees.size == 1
          shifts.size.times do |index|
            new_shift_name = "#{day_name}-#{index + 1}"
            shifts[new_shift_name][time_block] = employees.first
          end
        else
          employees.each_with_index do |employee, index|
            shifts[shift_name][time_block] = employee unless shifts[shift_name][time_block]

            new_shift_number = shift_number + index + 1
            new_shift_name = "#{day_name}-#{new_shift_number}"
            next if new_shift_number == employees.size + 1

            shifts[new_shift_name] = shifts[shift_name].dup unless shifts[new_shift_name]
            next_employee = employees[index + 1]
            shifts[new_shift_name][time_block] = next_employee
          end
        end
      end

      self.shifts[day_name] = shifts
    end
  end

  def build_shift_hours
    shifts.each do |_, shifts|
      shifts.each do |shift_name, shift|
        shifts_hours[shift_name] = shift.values.tally
      end
    end
  end

  def build_tentative_schedules
    tentative_shifts = []

    shifts.each_value do |shifts|
      tentative_shifts << shifts.keys
    end

    # .product no devuelve ningun resultado si uno de los arreglos esta vacío, por eso hay que filtrar los arreglos vacíos
    filtered_tentative_shifts = tentative_shifts.reject(&:empty?)

    self.tentative_schedules = filtered_tentative_shifts.shift.product(*filtered_tentative_shifts) if filtered_tentative_shifts.any?
  end

  def build_tentative_schedules_hours
    tentative_schedules.each_with_index do |tentative_schedule, index|
      tentative_schedules_hours[index] = {}
      tentative_schedule.each do |shift|
        shifts_hours[shift].each do |employee, total_hour|
          tentative_schedules_hours[index][employee] ||= 0
          tentative_schedules_hours[index][employee] += total_hour
        end
      end
    end
  end

  def get_optimal_solution
    arrays = []
    tentative_schedules_hours.each do |index, tentative_schedule_hour|
      arrays << tentative_schedule_hour.values
    end
    # From: ChatGPT
    # Le pregunte:
    # Teniendo los conjuntos [15, 19, 16], [10, 19, 21], [1, 2, 20], quiero elegir uno de esos arreglos bajo estas condiciones:
    # La diferencia entre los numeros en cada arreglo no debe ser demasiada. Ejemplo. 15, 19 y 16 no tienen mucha diferencia, pero 1, 2 y 20 tienen  mucha diferencia.
    # De entre todos tambien quiero elegir aquel arreglo cuya suma de su contenido se mayor a la suma de los contenidos de los otros arreglos

    # Calcular la suma y la máxima diferencia para cada arreglo
    arrays_with_sums_and_differences = arrays.map do |array|
      sum = array.sum
      difference = max_difference(array)
      { array: array, sum: sum, difference: difference }
    end

    # Filtrar arreglos con la suma máxima
    max_sum = arrays_with_sums_and_differences.map { |h| h[:sum] }.max
    filtered_arrays = arrays_with_sums_and_differences.select { |h| h[:sum] == max_sum }

    # Elegir el arreglo con la menor diferencia
    chosen_array = filtered_arrays.min_by { |h| h[:difference] }[:array]
    solution_index = arrays.index(chosen_array)
    [ chosen_array, solution_index ]
  end

  # Method para calcular la máxima diferencia en un arreglo
  def max_difference(array)
    array.max - array.min
  end

  def build_time_blocks(day_schedule)
    starts_at = day_schedule.starts_at
    while starts_at < day_schedule.ends_at
      ends_at = starts_at + 3600
      time_block = "#{starts_at.strftime("%H:%M")} - #{ends_at.strftime("%H:%M")}"
      yield(time_block)
      starts_at = ends_at
    end
  end

  def build_schedule(selected_schedule)
    selected_schedule.each do |shift|
      day_name = shift.split("-").first
      schedule[day_name] = shifts[day_name][shift]
    end
  end
end
