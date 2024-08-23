class ClientWeekSchedule < WeekSchedule
  alias_method :client, :owner
  delegate :name, to: :client, prefix: true
  def to_s
    "#{client_name} - #{super}"
  end

  # Setter para client.
  # alias_attribute no funciona con asociaciones polimórficas. Entonces, para emular su comportamiento se hace lo siguiente:
  # 1. Se usa alias_method para crear el getter client
  # 2. Se define client=() para crear el setter client
  def client=(client)
    self.owner = client
  end

  def self.get(week_number, year, client)
    DaySchedule.joins(:week_schedule, :day)
               .joins("inner join clients on clients.id = week_schedules.owner_id")
               .where(week_schedules: { type: "ClientWeekSchedule", week_number: week_number, year: year, owner_id: client.id })
               .select("day_schedules.*, week_schedules.owner_id as client_id, days.name as day_name")
               .order("days.order, clients.created_at")
               .index_by(&:day_name)
  end
end
