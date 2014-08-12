class RemoveColumnsFromEmployee < ActiveRecord::Migration
  def up
  	remove_column :employees, :position
  	remove_column :employees, :department
  	remove_column :employees, :group
  	remove_column :employees, :location
  end

  def down
  	add_column :employees, :position, :string
  	add_column :employees, :department, :string
  	add_column :employees, :group, :string
  	add_column :employees, :location, :string
  end
end

 