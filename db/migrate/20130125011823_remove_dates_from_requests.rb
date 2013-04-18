class RemoveDatesFromRequests < ActiveRecord::Migration
  def up
    remove_column :requests, :dates
  end

  def down
    add_column :requests, :dates, :string
  end
end
