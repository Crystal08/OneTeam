require 'spec_helper'

describe "EmployeeSkillEvaluations" do
  describe "GET /employee_skill_evaluations" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get employee_skill_evaluations_path
      response.status.should be(200)
    end
  end
end
