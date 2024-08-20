class CreateDaySchedules < ActiveRecord::Migration[7.2]
  def change
    create_table :day_schedules do |t|
      t.references :week_schedule, null: false, foreign_key: true
      t.references :day, null: false, foreign_key: true
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false

      t.timestamps
    end
  end
end
