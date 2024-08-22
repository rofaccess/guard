class MonitoringSchedule
  private attr_accessor :week_number, :year, :client, :shifts, :schedule

  def initialize(week_number, year, client)
    self.week_number = week_number
    self.year = year
    self.client = client
    self.shifts = {}
    self.schedule = {}
  end

  def build
    build_shifts
    a = 2
  end

  private

  def build_shifts
    Day.pluck(:name).each do |day_name|
      client_day_schedule = client_day_schedules[day_name]
      time_blocks = {}

      build_time_blocks(client_day_schedule) do |time_block|
        time_blocks[time_block] = []
      end

      employees_day_schedules[day_name].each do |employee_day_schedule|
        build_time_blocks(employee_day_schedule) do |time_block|
          time_blocks[time_block] << employee_day_schedule.employee_name
        end
      end

      shift_number = 1
      shifts = { shift_number => {} }

      time_blocks.each do |time_block, employees|
        if employees.size == 0
          shifts[shift_number][time_block] = nil
        elsif employees.size == 1
          shifts.size.times do |index|
            shifts[index + 1][time_block] = employees.first
          end
        else
          employees.each_with_index do |employee, index|
            shifts[shift_number][time_block] = employee unless shifts[shift_number][time_block]
            new_shift_number = shift_number + index + 1
            next if new_shift_number == employees.size + 1
            shifts[new_shift_number] = shifts[shift_number].dup unless shifts[new_shift_number]
            shifts[new_shift_number][time_block] = employees[index + 1]
          end
        end
      end

      self.shifts[day_name] = shifts
    end
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

  def client_week_schedules
    @client_week_schedules ||=
      ClientWeekSchedule.includes(:day_schedules).where(week_number: week_number, year: year, owner_id: client.id)
  end

  def employees_week_schedules
    @employees_week_schedules ||=
      EmployeeWeekSchedule.includes(:day_schedules).where(week_number: week_number, year: year).index_by(&:owner_id)
  end

  def employees_count
    @employees_count ||=
      employees_week_schedules.size
  end

  def client_day_schedules
    @client_day_schedules_by_day ||=
      DaySchedule.joins(:week_schedule, :day)
                 .joins("inner join clients on clients.id = week_schedules.owner_id")
                 .where(week_schedules: { type: "ClientWeekSchedule", week_number: week_number, year: year, owner_id: client.id })
                 .select("day_schedules.*, week_schedules.owner_id as client_id, days.name as day_name")
                 .order("days.order, clients.created_at")
                 .index_by(&:day_name)
  end

  def employees_day_schedules
    @employees_day_schedules_by_day ||=
      DaySchedule.joins(:week_schedule, :day)
                 .joins("inner join employees on employees.id = week_schedules.owner_id")
                 .where(week_schedules: { type: "EmployeeWeekSchedule", week_number: week_number, year: year })
                 .select("day_schedules.*, week_schedules.owner_id as employee_id, employees.name as employee_name, days.name as day_name")
                 .order("days.order, employees.created_at")
                 .group_by(&:day_name)
  end
end
