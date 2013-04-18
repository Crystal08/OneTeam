class EmployeeCurrentSkill < ActiveRecord::Base
  attr_accessible :employee_id, :skill_id, :skill_level

  belongs_to :employee
  belongs_to :skill

  def skill_name
  	Skill.find(self.skill_id).name
  end	
  
end
