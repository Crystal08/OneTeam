class Skill < ActiveRecord::Base
  attr_accessible :name

  #has_many :request_skills #Don't need this? Dr.Riesbeck says only need the two-liner in Request.rb, not here too (Same below)
  has_many :requests, :through => :request_skills

  #has_many :employee_current_skills
  has_many :employees, :through => :employee_current_skills

  #has_many :employee_desired_skills
  has_many :employees, :through => :employee_desired_skills

  has_many :employee_skill_evaluations
  #has_many :evaluations, :through => :employee_skill_evaluations

end

