class Request < ActiveRecord::Base
  attr_accessible :title, :employee_id, :task, :skills_needed,
   :location, :location_id, :start_date, :end_date, :group, :group_id
 
  belongs_to :employee
  belongs_to :location
  belongs_to :group
  
  has_many :responses
  has_many :selections
  
  accepts_nested_attributes_for :responses
  
  validates_presence_of :title, :location, :start_date, :end_date, :group
  validates :task, :length => { :maximum => 1500 }
  validate :start_date_first

  def start_date_first
    if !start_date.nil?
      if start_date > end_date
        errors.add(:start_date, 'must occur before end date')
      end
    end  
  end

  def selected?
    if Selection.find_by_request_id(id)
    end
  end

  def status
    if DateTime.now.to_date < start_date
      'Not Started'
    elsif DateTime.now.to_date >=
      start_date && DateTime.now.to_date <= end_date
      'In Progress'
    else
      'Completed'
    end
  end

  def done?
    DateTime.now.to_date > end_date
  end

  def find_responses(request)
    @responses = Response.where(:request_id => request.id)
  end

  def start_date_str
    start_date.strftime("%b %d %Y")
  end

  def end_date_str
    end_date.strftime("%b %d %Y")
  end

  def skill_names
    if !skills_needed.nil?
      skills_needed.split(", ") 
    else
      []  
    end
  end  

  def has_skill?(name)
    if !self.skill_names.nil?
      self.skill_names.include?(name)
    end  
  end 

  def current_skills_count(employee)
    request_skills = RequestSkill.where(:request_id => id)
    request_skill_ids = request_skills.map { |request_skill| request_skill.skill_id}
    employee_skills = CurrentSkill.where(:employee_id => employee.id)
    employee_skill_ids = employee_skills.map { |employee_skill| employee_skill.skill_id}    
    
    (request_skill_ids & employee_skill_ids).length
  end

  def skills_count 
    RequestSkill.where(:request_id => id).length
  end  
end

