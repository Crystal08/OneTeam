require 'spec_helper'

describe "employee_skill_evaluations/show" do
  before(:each) do
    @employee_skill_evaluation = assign(:employee_skill_evaluation, stub_model(EmployeeSkillEvaluation,
      :response_id => 1,
      :skill_id => 2,
      :assigned_skill_level => 3,
      :skill_experience_points => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
  end
end
