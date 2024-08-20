class DaySchedule < ApplicationRecord
  belongs_to :week_schedule
  belongs_to :day

  delegate :name, to: :day, prefix: true

  def to_s
    "#{day_name} #{starts_at.strftime("%H:%M")} - #{ends_at.strftime("%H:%M")}"
  end
end
