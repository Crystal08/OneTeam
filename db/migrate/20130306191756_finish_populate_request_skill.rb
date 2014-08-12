class FinishPopulateRequestSkill < ActiveRecord::Migration

#See "More Examples" here: http://api.rubyonrails.org/classes/ActiveRecord/Migration.html
  
  def up
  	Request.all.each do |r|
  	  r.skill_names.each do |sk|
  	  	sk_id = Skill.find_by_name(sk).id 
  	  	RequestSkill.create(:request_id => r.id, :skill_id => sk_id)
  	  end
  	end  	
  end

  def down
  end	

end


