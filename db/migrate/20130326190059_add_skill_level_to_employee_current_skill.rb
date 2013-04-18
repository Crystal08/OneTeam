class AddSkillLevelToEmployeeCurrentSkill < ActiveRecord::Migration
  def change
    add_column :employee_current_skills, :skill_level, :integer
  end
end
