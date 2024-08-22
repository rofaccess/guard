require "utils/day_utils"
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create clients
clients = [
  { name: "Recorrido.cl" },
  { name: "Google" }
]

Client.import(clients, on_duplicate_key_ignore: true)

# Create employees
employees = [
  { name: "Benjamín" },
  { name: "Bárbara" },
  { name: "Ernesto" }
]

Employee.import(employees, on_duplicate_key_ignore: true)

# Create days
days = []
DayUtils.day_names.each_with_index do |day_name, index|
  days << { name: day_name, order: index + 1 }
end

Day.import(days, on_duplicate_key_ignore: true)
days = Day.all.index_by(&:id).to_h

# Create client week schedules
client_week_schedule_hash =
  [
    { start_time: "19:00", end_time: "00:00", day: days[1] },
    { start_time: "19:00", end_time: "00:00", day: days[2] },
    { start_time: "19:00", end_time: "00:00", day: days[3] },
    { start_time: "19:00", end_time: "00:00", day: days[4] },
    { start_time: "19:00", end_time: "00:00", day: days[5] },
    { start_time: "10:00", end_time: "00:00", day: days[6] },
    { start_time: "10:00", end_time: "00:00", day: days[7] }
  ]

recorrido_client = Client.find_by(name: "Recorrido.cl")
week_number = 10
year = 2020
week_schedule = ClientWeekSchedule.build_from_hash(recorrido_client, week_number, year, client_week_schedule_hash)
week_schedule.save rescue ActiveRecord::RecordNotUnique => e
puts "employee week schedule save error: #{e}" if e

# Create employees week schedules
employee_1 = Employee.find_by(name: "Ernesto")
employee_2 = Employee.find_by(name: "Bárbara")
employee_3 = Employee.find_by(name: "Benjamín")

employees_week_schedules_hash =
  [
    { start_time: "19:00", end_time: "00:00", day: days[1], employee: employee_3 },
    { start_time: "19:00", end_time: "00:00", day: days[2], employee: employee_1 },
    { start_time: "19:00", end_time: "00:00", day: days[2], employee: employee_2 },
    { start_time: "19:00", end_time: "00:00", day: days[2], employee: employee_3 },
    { start_time: "19:00", end_time: "00:00", day: days[3], employee: employee_2 },
    { start_time: "19:00", end_time: "00:00", day: days[3], employee: employee_3 },
    { start_time: "19:00", end_time: "00:00", day: days[4], employee: employee_1 },
    { start_time: "19:00", end_time: "00:00", day: days[4], employee: employee_2 },
    { start_time: "19:00", end_time: "00:00", day: days[4], employee: employee_3 },
    { start_time: "19:00", end_time: "00:00", day: days[5], employee: employee_1 },
    { start_time: "19:00", end_time: "00:00", day: days[5], employee: employee_2 },
    { start_time: "10:00", end_time: "15:00", day: days[6], employee: employee_1 },
    { start_time: "18:00", end_time: "21:00", day: days[6], employee: employee_2 },
    { start_time: "18:00", end_time: "00:00", day: days[6], employee: employee_3 },
    { start_time: "10:00", end_time: "00:00", day: days[7], employee: employee_2 }
  ]

grouped_week_schedule_hash = employees_week_schedules_hash.group_by{ |shift| shift[:employee] }

week_schedule = EmployeeWeekSchedule.build_from_hash(employee_1, week_number, year, grouped_week_schedule_hash[employee_1])
week_schedule.save rescue ActiveRecord::RecordNotUnique => e
puts "client week schedule save error: #{e}" if e

week_schedule = EmployeeWeekSchedule.build_from_hash(employee_2, week_number, year, grouped_week_schedule_hash[employee_2])
week_schedule.save rescue ActiveRecord::RecordNotUnique => e
puts "client week schedule save error: #{e}" if e

week_schedule = EmployeeWeekSchedule.build_from_hash(employee_3, week_number, year, grouped_week_schedule_hash[employee_3])
week_schedule.save rescue ActiveRecord::RecordNotUnique => e
puts "client week schedule save error: #{e}" if e
