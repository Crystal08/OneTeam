class AddLocationToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :location, :string
  end
end
