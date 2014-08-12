require 'spec_helper'

describe "desired_skills/index" do
  before(:each) do
    assign(:desired_skills, [
      stub_model(DesiredSkill,
        :skill_id => 1,
        :employee_id => 2,
        :interest_level => 3
      ),
      stub_model(DesiredSkill,
        :skill_id => 1,
        :employee_id => 2,
        :interest_level => 3
      )
    ])
  end

  it "renders a list of desired_skills" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
