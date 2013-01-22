class Employee < ActiveRecord::Base
  attr_accessible :name, :years_with_company, :manager, :position, :department, :group, :location, :current_skills, :skills_interested_in, :password, :password_confirmation
  has_secure_password

  has_many :requests
  has_many :responses, dependent: :destroy

  before_save :create_remember_token

 private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
