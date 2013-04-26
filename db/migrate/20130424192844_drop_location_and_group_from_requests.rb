class DropLocationAndGroupFromRequests < ActiveRecord::Migration
  def up
  	remove_column :requests, :location
    remove_column :requests, :group
  end

  def down
  	add_column :requests, :location, :string
  	add_column :requests, :group, :string
  end
end

