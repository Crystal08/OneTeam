class RemoveDashboardTable < ActiveRecord::Migration
  def up
  	drop_table :dashboards
  end

  def down
  	add_table :dashboards
  end
end
