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
end
