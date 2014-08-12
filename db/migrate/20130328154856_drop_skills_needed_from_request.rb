class DropSkillsNeededFromRequest < ActiveRecord::Migration
  def up
  	remove_column :requests, :skills_needed
  end

  def down
  	add_column :requests, :skills_needed, :string
  end
end
