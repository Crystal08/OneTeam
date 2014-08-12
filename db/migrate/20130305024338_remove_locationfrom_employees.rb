class RemoveLocationfromEmployees < ActiveRecord::Migration
  def up
  	remove_column :employees, :location
  end

  def down
  	remove_column :employees, :location, :string
  end
end
