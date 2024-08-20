class CreateWeekSchedules < ActiveRecord::Migration[7.2]
  def change
    create_table :week_schedules do |t|
      t.integer :week_number, null: false
      t.integer :year, null: false
      t.string :type, null: false
      t.references :owner, polymorphic: true, null: false

      t.timestamps
    end
  end
end
