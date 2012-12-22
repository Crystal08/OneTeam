class Employee < ActiveRecord::Base
  attr_accessible :name, :years_with_company, :manager, :position, :department, :group, :location, :current_skills, :skills_interested_in, :password, :password_confirmation

  has_secure_password
  has_many :requests
  has_many :responses

  validates :name, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

end
