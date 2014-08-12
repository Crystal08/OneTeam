class AddEvaluationIdToEmployeeSkillEvaluation < ActiveRecord::Migration
  def change
	add_column :employee_skill_evaluations, :evaluation_id, :integer
  end
end
