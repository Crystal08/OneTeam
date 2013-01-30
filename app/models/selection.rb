class Selection < ActiveRecord::Base
  attr_accessible :employee_id, :notes, :request_id, :response_id

  belongs_to :response
  belongs_to :request
  belongs_to :employee  

end
