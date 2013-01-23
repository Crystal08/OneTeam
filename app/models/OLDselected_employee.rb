class SelectedEmployee < ActiveRecord::Base
  attr_accessible :name, :employee_id, :request_id, :response_id, :notes

  belongs_to :request
  belongs_to :response
  belongs_to :employee

end
