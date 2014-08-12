class RemoveCurrentSkillsFromEmployee < ActiveRecord::Migration
  def up
  	remove_column :employees, :current_skills
  end

  def down
  	add_column :employees, :current_skills, :string
  end
end
