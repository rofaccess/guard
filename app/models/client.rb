class Client < ApplicationRecord
  has_many :week_schedules, as: :client
end
