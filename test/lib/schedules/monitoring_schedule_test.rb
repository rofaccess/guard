require "test_helper"
require "schedules/monitoring_schedule"

class MonitoringScheduleTest < ActiveSupport::TestCase
  test "the truth" do
    MonitoringSchedule.create
    assert true
  end
end
