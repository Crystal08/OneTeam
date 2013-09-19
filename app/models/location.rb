class Location < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude

  has_many :employees
  has_many :requests
  
end
