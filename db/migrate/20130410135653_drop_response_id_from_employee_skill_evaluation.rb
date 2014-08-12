class DropResponseIdFromEmployeeSkillEvaluation < ActiveRecord::Migration
  def up
  	remove_column :employee_skill_evaluations, :response_id
  end

  def down
  	add_column :employee_skill_evaluations, :response_id, :integer
  end
end

