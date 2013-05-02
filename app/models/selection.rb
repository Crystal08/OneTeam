class Selection < ActiveRecord::Base
  attr_accessible :notes, :response_id, :created_at
  #Took out :request_id b/c request can be accessed through response

  belongs_to :response
  belongs_to :request
  belongs_to :employee

  has_many :responses
  has_many :requests, :through => :responses  

end
