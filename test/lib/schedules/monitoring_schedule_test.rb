require "test_helper"
require "schedules/monitoring_schedule"
require "schedules/basic_scheduler"

class MonitoringScheduleTest < ActiveSupport::TestCase
  test "create schedule" do
    MonitoringSchedule.create
    assert(true)
  end

  test "basic scheduler" do
    # Luego probar el ends_at con 23:59:59
    people = [
      {
        name: "Ernesto",
        availability: [ # person 0: Ernesto
          { starts_at: Time.parse("2020-03-03 19:00:00"), ends_at: Time.parse("2020-03-04 00:00:00") }, # Mar 03 de Marzo
          { starts_at: Time.parse("2020-03-05 19:00:00"), ends_at: Time.parse("2020-03-06 00:00:00") }, # Jue 05 de Marzo
          { starts_at: Time.parse("2020-03-06 19:00:00"), ends_at: Time.parse("2020-03-07 00:00:00") }, # Vie 06 de Marzo
          { starts_at: Time.parse("2020-03-07 10:00:00"), ends_at: Time.parse("2020-03-07 15:00:00") } # Sáb 07 de Marzo
        ]
      },
      {
        name: "Bárbara",
        availability: [ # person 1: Bárbara
          { starts_at: Time.parse("2020-03-03 19:00:00"), ends_at: Time.parse("2020-03-04 00:00:00") }, # Mar 03 de Marzo
          { starts_at: Time.parse("2020-03-04 19:00:00"), ends_at: Time.parse("2020-03-05 00:00:00") }, # Mie 04 de Marzo
          { starts_at: Time.parse("2020-03-05 19:00:00"), ends_at: Time.parse("2020-03-06 00:00:00") }, # Jue 05 de Marzo
          { starts_at: Time.parse("2020-03-06 19:00:00"), ends_at: Time.parse("2020-03-07 00:00:00") }, # Vie 06 de Marzo
          { starts_at: Time.parse("2020-03-07 18:00:00"), ends_at: Time.parse("2020-03-07 21:00:00") }, # Sáb 07 de Marzo
          { starts_at: Time.parse("2020-03-08 10:00:00"), ends_at: Time.parse("2020-03-09 00:00:00") } # Dom 08 de Marzo
        ]
      },
      {
        name: "Benjamín",
        availability: [ # person 2: Benjamín
          { starts_at: Time.parse("2020-03-02 19:00:00"), ends_at: Time.parse("2020-03-03 00:00:00") }, # Lun 02 de Marzo
          { starts_at: Time.parse("2020-03-03 19:00:00"), ends_at: Time.parse("2020-03-04 00:00:00") }, # Mar 03 de Marzo
          { starts_at: Time.parse("2020-03-05 19:00:00"), ends_at: Time.parse("2020-03-06 00:00:00") }, # Jue 05 de Marzo
          { starts_at: Time.parse("2020-03-07 18:00:00"), ends_at: Time.parse("2020-03-08 00:00:00") }  # Sáb 07 de Marzo
        ]
      }
    ]

    shifts = [
      { starts_at: Time.parse("2020-03-02 19:00:00"), ends_at: Time.parse("2020-03-03 00:00:00") }, # 0: Lun 02 de Marzo
      { starts_at: Time.parse("2020-03-03 19:00:00"), ends_at: Time.parse("2020-03-04 00:00:00") }, # 1: Mar 03 de Marzo
      { starts_at: Time.parse("2020-03-04 19:00:00"), ends_at: Time.parse("2020-03-05 00:00:00") }, # 2: Mie 04 de Marzo
      { starts_at: Time.parse("2020-03-05 19:00:00"), ends_at: Time.parse("2020-03-06 00:00:00") }, # 3: Jue 05 de Marzo
      { starts_at: Time.parse("2020-03-06 19:00:00"), ends_at: Time.parse("2020-03-07 00:00:00") }, # 4: Vie 06 de Marzo
      { starts_at: Time.parse("2020-03-07 10:00:00"), ends_at: Time.parse("2020-03-08 00:00:00") }, # 5: Sáb 07 de Marzo
      { starts_at: Time.parse("2020-03-08 10:00:00"), ends_at: Time.parse("2020-03-09 00:00:00") }  # 6: Dom 08 de Marzo
    ]

    scheduler = BasicScheduler.new(people: people, shifts: shifts)

    puts
    scheduler.assignments.each do |assignment|
      puts "#{people[assignment[:person]][:name]}: #{shifts[assignment[:shift]][:starts_at].strftime('%a %d %b %Y')}"
    end

    puts "--------------"
    puts scheduler.assigned_hours
    puts "--------------"
    puts scheduler.total_hours

    assert(true)
  end

  test "basic scheduler example" do
    people = [
      {
        availability: [ # person 0
          { starts_at: Time.parse("2020-01-01 08:00:00"), ends_at: Time.parse("2020-01-01 16:00:00") },
          { starts_at: Time.parse("2020-01-02 08:00:00"), ends_at: Time.parse("2020-01-02 16:00:00") }
        ],
        max_hours: 40 # optional, applies to entire scheduling period
      },
      {
        availability: [ # person 1
          { starts_at: Time.parse("2020-01-01 08:00:00"), ends_at: Time.parse("2020-01-01 16:00:00") },
          { starts_at: Time.parse("2020-01-03 08:00:00"), ends_at: Time.parse("2020-01-03 16:00:00") }
        ],
        max_hours: 20
      }
    ]

    shifts = [
      { starts_at: Time.parse("2020-01-01 08:00:00"), ends_at: Time.parse("2020-01-01 16:00:00") }, # shift 0
      { starts_at: Time.parse("2020-01-02 08:00:00"), ends_at: Time.parse("2020-01-02 16:00:00") }, # shift 1
      { starts_at: Time.parse("2020-01-03 08:00:00"), ends_at: Time.parse("2020-01-03 16:00:00") }  # shift 2
    ]

    scheduler = BasicScheduler.new(people: people, shifts: shifts)

    puts scheduler.assignments
    puts "--------------"
    puts scheduler.assigned_hours
    puts "--------------"
    puts scheduler.total_hours

    assert(true)
  end
end
