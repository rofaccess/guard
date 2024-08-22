class AddColorClassToEmployees < ActiveRecord::Migration[7.2]
  def change
    add_column :employees, :color_class, :string
  end
end
