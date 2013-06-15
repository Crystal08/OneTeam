class DropEmployeeIdFromSelections < ActiveRecord::Migration
  def up
  	remove_column :selections, :employee_id
  	remove_column :selections, :request_id
  end

  def down
  	add_column :selections, :employee_id, :integer
  	add_column :selections, :request_id, :integer
  end
end
