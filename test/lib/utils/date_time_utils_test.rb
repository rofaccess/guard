require "test_helper"
require "utils/date_time_utils"
class DateTimeUtilsTest < ActiveSupport::TestCase
  test "Should build date" do
    assert_equal("2020-03-02", DateTimeUtils.build_date(10, 2020, "Monday").to_s)
  end

  test "Should build time" do
    assert_equal("2020-03-02 19:00",
                 DateTimeUtils.build_time(10, 2020, "Monday", "19:00")
                              .strftime("%Y-%m-%d %H:%M")
    )
  end
end
