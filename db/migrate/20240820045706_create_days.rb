class CreateDays < ActiveRecord::Migration[7.2]
  def change
    create_table :days do |t|
      t.string :name, null: false, index: { unique: true }
      t.integer :order, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
