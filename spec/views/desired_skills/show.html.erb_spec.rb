require 'spec_helper'

describe "desired_skills/show" do
  before(:each) do
    @desired_skill = assign(:desired_skill, stub_model(DesiredSkill,
      :skill_id => 1,
      :employee_id => 2,
      :interest_level => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
