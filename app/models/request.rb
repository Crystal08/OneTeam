class Request < ActiveRecord::Base
  attr_accessible :employee_id, :task, :skills_needed, :location, :start_date, :end_date, :group, :lead, :contact, :status
 
  belongs_to :employee
  
  has_many :responses
  has_many :selections
  
  accepts_nested_attributes_for :responses
  
  validates :task, :length => { :maximum => 1500 }
end
