class MonitoringSchedule
  class << self
    def create
      people = [
        {
          availability: [
            { starts_at: Time.parse("2020-01-01 08:00:00"), ends_at: Time.parse("2020-01-01 16:00:00") },
            { starts_at: Time.parse("2020-01-02 08:00:00"), ends_at: Time.parse("2020-01-02 16:00:00") }
          ],
          max_hours: 40 # optional, applies to entire scheduling period
        },
        {
          availability: [
            { starts_at: Time.parse("2020-01-01 08:00:00"), ends_at: Time.parse("2020-01-01 16:00:00") },
            { starts_at: Time.parse("2020-01-03 08:00:00"), ends_at: Time.parse("2020-01-03 16:00:00") }
          ],
          max_hours: 20
        }
      ]

      shifts = [
        { starts_at: Time.parse("2020-01-01 08:00:00"), ends_at: Time.parse("2020-01-01 16:00:00") },
        { starts_at: Time.parse("2020-01-02 08:00:00"), ends_at: Time.parse("2020-01-02 16:00:00") },
        { starts_at: Time.parse("2020-01-03 08:00:00"), ends_at: Time.parse("2020-01-03 16:00:00") }
      ]

      scheduler = ORTools::BasicScheduler.new(people: people, shifts: shifts)

      puts scheduler.assignments
      puts scheduler.assigned_hours
      puts scheduler.total_hours
    end
  end
end
