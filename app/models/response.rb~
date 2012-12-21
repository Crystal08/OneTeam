class Response < ActiveRecord::Base
  attr_accessible :request_id, :employee_id, :comments
  has_many :employees, :through => :requests
  belongs_to :request
end
