require 'spec_helper'

describe "employee_skill_evaluations/index" do
  before(:each) do
    assign(:employee_skill_evaluations, [
      stub_model(EmployeeSkillEvaluation,
        :response_id => 1,
        :skill_id => 2,
        :assigned_skill_level => 3,
        :skill_experience_points => 4
      ),
      stub_model(EmployeeSkillEvaluation,
        :response_id => 1,
        :skill_id => 2,
        :assigned_skill_level => 3,
        :skill_experience_points => 4
      )
    ])
  end

  it "renders a list of employee_skill_evaluations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
