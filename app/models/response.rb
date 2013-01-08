class Response < ActiveRecord::Base
  attr_accessible :request_id, :employee_id, :comments
  belongs_to :employee
  belongs_to :request
end
