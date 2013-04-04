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

  #.nil? did NOT work below because [] returns true!!
  def has_skill_level?(skill_id, level_number)
    self.employee_current_skills.each do |cs|
      return true if cs.skill_id == skill_id && cs.skill_level == level_number
    end
    level_number == 0  
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

  #.nil? did NOT work below because [] returns true!!
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


