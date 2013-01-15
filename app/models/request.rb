class Request < ActiveRecord::Base
  attr_accessible :employee_id, :task, :skills_needed, :location, :dates, :group, :lead, :contact
 
  belongs_to :employee
  has_many :responses, :dependent => :destroy
 
  accepts_nested_attributes_for :responses
  
  validates :task, :length => { :maximum => 1500 }
end
