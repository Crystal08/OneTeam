class Request < ActiveRecord::Base
  attr_accessible :title, :employee_id, :task, :request_skill_ids,
   :location, :location_id, :start_date, :end_date, :group, :group_id
 
  belongs_to :employee
  belongs_to :location
  belongs_to :group
  
  has_many :responses
  has_many :selections
  # See http://stackoverflow.com/questions/4394803/rails-model-belongs-to-many
  has_many :request_skills
  has_many :skills, :through => :request_skills

  accepts_nested_attributes_for :responses
  
  validates_presence_of :title, :location, :start_date, :end_date, :group
  validates :task, :length => { :maximum => 1500 }
  validate :start_date_first

  def start_date_first
    errors.add(:start_date, 'must occur before end date') if !start_date.nil? && start_date > end_date
  end    

  def selected?
    !Selection.find_by_response_id(id).nil?
  end

  def evaluated?(employee)
    self.responses.each do |response|
      if response.employee_id == employee.id && !response.evaluation.nil?
        return true
      else
        return false
      end 
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

  def days_long
    (self.end_date.to_date - self.start_date.to_date).to_i
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

  def request_skill_ids
    self.skills.map {|s| s.id}
  end
  
  def request_skill_ids= (ids)
    self.request_skills = make_request_skill_array(ids)
  end  

  def make_request_skill_array(ids)
    ids.map {|id| RequestSkill.create(:skill_id => id)}
  end    

  def current_skills_count(employee)
    current_skills = []
    employee.employee_current_skills.each do |cs|
      if cs.skill_level != 0
        current_skills << Skill.find(cs.skill_id)
      end
    end  
    (self.skills & current_skills).count
  end

  def current_skills_score(employee)
    skill_level_array = []
    request_skill_ids.each do |rs_id|
      employee.employee_current_skills.each do |cs|
        if cs.skill_level != 0 && cs.skill_id == rs_id
          skill_level_array << cs.skill_level
        end  
      end
    end  
    skill_level_array.sum
  end

  def desired_skills_count(employee)
    desired_skills = []
    employee.employee_desired_skills.each do |ds|
      if ds.interest_level != 0
        desired_skills << Skill.find(ds.skill_id)
      end
    end
    (self.skills & desired_skills).count
  end          

  def desired_skills_score(employee)
    skill_interest_array = []
    request_skill_ids.each do |rs_id|
      employee.employee_desired_skills.each do |ecs|
        if ecs.interest_level != 0 && ecs.skill_id == rs_id
          skill_interest_array << ecs.interest_level
        end  
      end
    end  
    skill_interest_array.sum
  end

end


