class Employee < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :about_me, 
  :image, :email, :years_with_company, :manager, :position, :position_id,
  :department, :department_id, :group, :group_id, :location, :location_id, :current_skills, 
  :skills_interested_in, :password, :password_confirmation
  has_secure_password

  has_many :requests
  has_many :responses, :dependent => :destroy
  has_many :selections
  has_many :skills
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

  def skills
    if !current_skills.nil?
      current_skills.split(", ") || []
    end
  end  

  def has_skill?(name)
    if !self.skills.nil?
      self.skills.include?(name)
    end  
  end 

  def skills_interested
    if !skills_interested_in.nil?
      skills_interested_in.split(", ") || []
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


