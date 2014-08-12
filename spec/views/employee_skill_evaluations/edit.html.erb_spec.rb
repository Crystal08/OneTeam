require 'spec_helper'

describe "employee_skill_evaluations/edit" do
  before(:each) do
    @employee_skill_evaluation = assign(:employee_skill_evaluation, stub_model(EmployeeSkillEvaluation,
      :response_id => 1,
      :skill_id => 1,
      :assigned_skill_level => 1,
      :skill_experience_points => 1
    ))
  end

  it "renders the edit employee_skill_evaluation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => employee_skill_evaluations_path(@employee_skill_evaluation), :method => "post" do
      assert_select "input#employee_skill_evaluation_response_id", :name => "employee_skill_evaluation[response_id]"
      assert_select "input#employee_skill_evaluation_skill_id", :name => "employee_skill_evaluation[skill_id]"
      assert_select "input#employee_skill_evaluation_assigned_skill_level", :name => "employee_skill_evaluation[assigned_skill_level]"
      assert_select "input#employee_skill_evaluation_skill_experience_points", :name => "employee_skill_evaluation[skill_experience_points]"
    end
  end
end
