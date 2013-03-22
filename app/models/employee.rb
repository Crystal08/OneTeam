class Employee < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :about_me, 
  :image, :email, :years_with_company, :manager, :position, :position_id,
  :department, :department_id, :group, :group_id, :location, :location_id, :current_skills, 
  :skills_interested_in, :password, :password_confirmation
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


  validates_presence_of :first_name, :last_name, :email, :location, :department, :group, :position

  before_save :create_remember_token

  def full_name
    "#{first_name} #{last_name}"
  end

  def skill_names
    if !current_skills.nil?
      current_skills.split(", ") 
    else
      []  
    end
  end  

  def has_skill?(name)
    if !self.skill_names.nil?
      self.skill_names.include?(name)
    end  
  end 

  def skills_interested
    if !skills_interested_in.nil?
      skills_interested_in.split(", ")
    else
      []  
    end
  end    

  def wants_skill?(name)
    if !self.skills_interested.nil?
      self.skills_interested.include?(name)
    end  
  end 

  def current_skills= (skills)
    write_attribute(:current_skills, skills.delete_if {|x| x == ""}.join(", "))
  end

  def skills_interested_in= (skills)
    write_attribute(:skills_interested_in, skills.delete_if {|x| x == ""}.join(", "))
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end


