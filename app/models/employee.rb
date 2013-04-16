class Employee < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :about_me, 
  :image, :email, :years_with_company, :manager, :position, :position_id,
  :department, :department_id, :group, :group_id, :location, :location_id, 
  :current_skills, :current_skill_ids, :desired_skills, :desired_skill_ids, :password, :password_confirmation
  has_secure_password

  has_many :requests
  has_many :responses, :dependent => :destroy
  has_many :selections
  #http://kconrails.com/2010/01/29/has_and_belongs_to_many-associations-in-ruby-on-rails/
  
  has_many :employee_current_skills
  has_many :current_skills, :through => :employee_current_skills, :source => :skill #option here says what type of object 'current skills' is (the name I've defined for this group of methods), here a skill object
  
  has_many :employee_desired_skills
  has_many :desired_skills, :through => :employee_desired_skills, :source => :skill 
  
  has_many :departments
  belongs_to :location
  belongs_to :group
  belongs_to :department
  belongs_to :position

  accepts_nested_attributes_for :employee_current_skills
  accepts_nested_attributes_for :employee_desired_skills

  validates_presence_of :first_name, :last_name, :email, :location, :department, :group, :position

  before_save :create_remember_token

  def full_name
    "#{first_name} #{last_name}"
  end

  def has_skill_level?(skill_id, level_number)
    self.employee_current_skills.each do |cs|
      return true if cs.skill_id == skill_id && cs.skill_level == level_number
    end
    level_number == 0  
  end 

  def skill_experience_total(skill_id)
    all_points = []
    EmployeeSkillEvaluation.all.each do |sk_eval|
      if sk_eval.evaluation.response.employee_id == self.id && sk_eval.skill_id == skill_id
        all_points << sk_eval.skill_experience_points
      end
    end
    all_points.sum
  end  

  def average_skill_level(skill_id) 
    all_levels = []
    EmployeeSkillEvaluation.all.each do |sk_eval|
      if sk_eval.evaluation.response.employee_id == self.id && sk_eval.skill_id == skill_id   
        all_levels << sk_eval.assigned_skill_level
      end
    end
    if !all_levels.empty?
      (all_levels.inject{ |sum, level| sum + level}.to_f / all_levels.size).to_i
    else
      "n/a"
    end
  end

  def skill_experience(request, skill_id)
    request.responses.each do |response|
      if response.employee_id == self.id && !response.evaluation.nil?
        response.evaluation.employee_skill_evaluations.each do |sk_eval|
          if sk_eval.skill_id == skill_id
            return sk_eval.skill_experience_points
          end
        end
      else 
        0
      end
    end
  end          
 
  def skill_level(request, skill_id)
    request.responses.each do |response|
      if response.employee_id == self.id && !response.evaluation.nil?
        response.evaluation.employee_skill_evaluations.each do |sk_eval|
          if sk_eval.skill_id == skill_id
            return sk_eval.assigned_skill_level
          end
        end
      else 
        return 0
      end
    end
  end

  def current_skill_ids
    self.current_skills.map {|cs| cs.skill_id}
  end

  def current_skills= (ids_with_levels)
    self.employee_current_skills = make_current_skill_array(ids_with_levels)
  end

  def make_current_skill_array(ids_with_levels)
    ids_with_levels.map {|skill_id, level_number| EmployeeCurrentSkill.create(:skill_id => skill_id, :skill_level => level_number)}
  end 

  def has_interest_level?(skill_id, interest_number)
    self.employee_desired_skills.each do |ds|
      return true if ds.skill_id == skill_id && ds.interest_level == interest_number
    end
    interest_number == 0  
  end 

  def desired_skill_ids
    self.desired_skills.map {|ds| ds.skill_id}
  end
  
  def desired_skills= (ids_with_levels)
    self.employee_desired_skills = make_desired_skill_array(ids_with_levels)
  end
  
  def make_desired_skill_array(ids_with_levels)
    ids_with_levels.map {|skill_id, interest_number| EmployeeDesiredSkill.create(:skill_id => skill_id, :interest_level => interest_number)}
  end

  private

  def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
  end

end


