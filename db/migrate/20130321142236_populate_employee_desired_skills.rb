class PopulateEmployeeDesiredSkills < ActiveRecord::Migration
  def up
  	Employee.all.each do |e|
  	  e.skills_interested.each do |sk|
  	  	sk_id = Skill.find_by_name(sk).id
  	  	EmployeeDesiredSkill.create(:employee_id => e.id, :skill_id => sk_id)
  	  end	
    end
  end

  def down
  end
end


