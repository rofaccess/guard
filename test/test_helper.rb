ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "utils/table_utils"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def client_week_schedule_hash
      [
        { start_time: "19:00", end_time: "00:00", day: day_1 },
        { start_time: "19:00", end_time: "00:00", day: day_2 },
        { start_time: "19:00", end_time: "00:00", day: day_3 },
        { start_time: "19:00", end_time: "00:00", day: day_4 },
        { start_time: "19:00", end_time: "00:00", day: day_5 },
        { start_time: "10:00", end_time: "00:00", day: day_6 },
        { start_time: "10:00", end_time: "00:00", day: day_7 }
      ]
    end

    def employees_week_schedules_hash
      [
        { start_time: "19:00", end_time: "00:00", day: day_1, employee: employee_3 },
        { start_time: "19:00", end_time: "00:00", day: day_2, employee: employee_1 },
        { start_time: "19:00", end_time: "00:00", day: day_2, employee: employee_2 },
        { start_time: "19:00", end_time: "00:00", day: day_2, employee: employee_3 },
        { start_time: "19:00", end_time: "00:00", day: day_3, employee: employee_2 },
        { start_time: "19:00", end_time: "00:00", day: day_3, employee: employee_3 },
        { start_time: "19:00", end_time: "00:00", day: day_4, employee: employee_1 },
        { start_time: "19:00", end_time: "00:00", day: day_4, employee: employee_2 },
        { start_time: "19:00", end_time: "00:00", day: day_4, employee: employee_3 },
        { start_time: "19:00", end_time: "00:00", day: day_5, employee: employee_1 },
        { start_time: "19:00", end_time: "00:00", day: day_5, employee: employee_2 },
        { start_time: "10:00", end_time: "15:00", day: day_6, employee: employee_1 },
        { start_time: "18:00", end_time: "21:00", day: day_6, employee: employee_2 },
        { start_time: "18:00", end_time: "00:00", day: day_6, employee: employee_3 },
        { start_time: "10:00", end_time: "00:00", day: day_7, employee: employee_2 }
      ]
    end

    def week_number = 11
    def year = 2020
    def week_schedule_title = "Semana #{week_number} - #{year}"
    def client_1 = clients(:recorrido_cl)
    def employee_1 = employees(:ernesto)
    def employee_2 = employees(:barbara)
    def employee_3 = employees(:benjamin)

    def day_1 = days(:monday)
    def day_2 = days(:tuesday)
    def day_3 = days(:wednesday)
    def day_4 = days(:thursday)
    def day_5 = days(:friday)
    def day_6 = days(:saturday)
    def day_7 = days(:sunday)
  end
end
