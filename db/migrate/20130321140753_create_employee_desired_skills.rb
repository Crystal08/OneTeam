class CreateEmployeeDesiredSkills < ActiveRecord::Migration
  def change
    create_table :employee_desired_skills do |t|
      t.integer :employee_id
      t.integer :skill_id

      t.timestamps
    end
  end
end
