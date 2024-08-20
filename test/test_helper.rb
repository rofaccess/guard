ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def client
      "Recorrido.cl"
    end

    def client_week_schedule_hash
      {
        "Monday" => { start_time: "19:00", end_time: "00:00" },
        "Tuesday" => { start_time: "19:00", end_time: "00:00" },
        "Wednesday" => { start_time: "19:00", end_time: "00:00" },
        "Thursday" => { start_time: "19:00", end_time: "00:00" },
        "Friday" => { start_time: "19:00", end_time: "00:00" },
        "Saturday" => { start_time: "10:00", end_time: "00:00" },
        "Sunday" => { start_time: "10:00", end_time: "00:00" }
      }
    end

    def employee_1
      "Ernesto"
    end

    def employee_2
      "Bárbara"
    end

    def employee_3
      "Benjamín"
    end

    def employees_week_schedules_hash
      [
        { day_name: "Monday", start_time: "19:00", end_time: "00:00", employee: employee_3 },
        { day_name: "Tuesday", start_time: "19:00", end_time: "00:00", employee: employee_1 },
        { day_name: "Tuesday", start_time: "19:00", end_time: "00:00", employee: employee_2 },
        { day_name: "Tuesday", start_time: "19:00", end_time: "00:00", employee: employee_3 },
        { day_name: "Wednesday", start_time: "19:00", end_time: "00:00", employee: employee_2 },
        { day_name: "Wednesday", start_time: "19:00", end_time: "00:00", employee: employee_3 },
        { day_name: "Thursday", start_time: "19:00", end_time: "00:00", employee: employee_1 },
        { day_name: "Thursday", start_time: "19:00", end_time: "00:00", employee: employee_2 },
        { day_name: "Thursday", start_time: "19:00", end_time: "00:00", employee: employee_3 },
        { day_name: "Friday", start_time: "19:00", end_time: "00:00", employee: employee_1 },
        { day_name: "Friday", start_time: "19:00", end_time: "00:00", employee: employee_2 },
        { day_name: "Saturday", start_time: "10:00", end_time: "15:00", employee: employee_1 },
        { day_name: "Saturday", start_time: "18:00", end_time: "21:00", employee: employee_2 },
        { day_name: "Saturday", start_time: "18:00", end_time: "00:00", employee: employee_3 },
        { day_name: "Sunday", start_time: "10:00", end_time: "00:00", employee: employee_2 }
      ]
    end
  end
end
