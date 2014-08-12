require 'spec_helper'

describe "desired_skills/edit" do
  before(:each) do
    @desired_skill = assign(:desired_skill, stub_model(DesiredSkill,
      :skill_id => 1,
      :employee_id => 1,
      :interest_level => 1
    ))
  end

  it "renders the edit desired_skill form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => desired_skills_path(@desired_skill), :method => "post" do
      assert_select "input#desired_skill_skill_id", :name => "desired_skill[skill_id]"
      assert_select "input#desired_skill_employee_id", :name => "desired_skill[employee_id]"
      assert_select "input#desired_skill_interest_level", :name => "desired_skill[interest_level]"
    end
  end
end
