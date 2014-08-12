class SetEmployeeCurrentSkillSkillLevels < ActiveRecord::Migration
  def up
  	EmployeeCurrentSkill.all.each do |ecs|
      ecs.update_attributes(:skill_level => 3)
    end 
  end

  def down
  end
end
