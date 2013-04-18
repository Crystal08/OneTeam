class AddGroupIdToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :group_id, :integer
  end
end
