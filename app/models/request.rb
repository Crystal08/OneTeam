class Request < ActiveRecord::Base
  attr_accessible :title, :employee_id, :task, :skills_needed,
   :location, :start_date, :end_date, :group
 
  belongs_to :employee
  
  has_many :responses
  has_many :selections
  
  accepts_nested_attributes_for :responses
  
  validates_presence_of :title, :start_date, :end_date
  validates :task, :length => { :maximum => 1500 }
  validate :start_date_first

  def start_date_first
      if start_date > end_date
        errors.add(:start_date, 'must occur before end date')
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

  def skills
    if !skills_needed.nil?
      skills_needed.split(", ") || []
    end
  end  

  def has_skill?(name)
    if !self.skills.nil?
      self.skills.include?(name)
    end  
  end 

  def skills_needed= (skills)
    write_attribute(:skills_needed, skills.delete_if {|x| x == ""}.join(", "))
  end

end