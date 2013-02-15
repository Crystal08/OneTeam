class Request < ActiveRecord::Base
  attr_accessible :title, :employee_id, :task, :skills_needed, :location, :start_date, :end_date, :group, :lead, :contact
 
  belongs_to :employee
  
  has_many :responses
  has_many :selections
  
  accepts_nested_attributes_for :responses
  
  validates :task, :length => { :maximum => 1500 }
  validate :start_date_first

  def start_date_first
      if start_date > end_date
        errors.add(:start_date, 'must occur before end date')
      end   
  end  

  def not_selected(request)
    !Selection.find_by_request_id(request)
  end

  def status(request)
    @current_date = DateTime.now.to_date
    if @current_date < request.start_date  
      'Not Started'
    elsif @current_date >= request.start_date && @current_date <= request.end_date
      'In Progress' 
    else
      'Completed'
    end 
  end  

  def find_responses(request)
    @responses = Response.where(:request_id => request.id)
  end     

end
