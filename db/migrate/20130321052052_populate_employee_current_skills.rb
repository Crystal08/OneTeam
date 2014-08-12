class PopulateEmployeeCurrentSkills < ActiveRecord::Migration
  def up
  	Employee.all.each do |e|
  	  e.skill_names.each do |sk|
  	  	sk_id = Skill.find_by_name(sk).id
  	  	EmployeeCurrentSkill.create(:employee_id => e.id, :skill_id => sk_id)
  	  end	
    end
  end

  def down
  end
end

