# Define el horario de inicio a fin de un día
class DaySchedule
  attr_accessor :starts_at, :ends_at
  def initialize(starts_at, ends_at)
    self.starts_at = starts_at
    self.ends_at = ends_at
  end

  def day
    starts_at.strftime("%A")
  end
  def to_s
    "#{day} #{starts_at.strftime("%H:%M")} - #{ends_at.strftime("%H:%M")}"
  end
end
