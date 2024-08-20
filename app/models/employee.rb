class Employee < ApplicationRecord
  has_many :week_schedules, as: :owner
end
