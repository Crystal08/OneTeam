class AddInterestLevelToEmployeeDesiredSkills < ActiveRecord::Migration
  def change
    add_column :employee_desired_skills, :interest_level, :integer
  end
end
