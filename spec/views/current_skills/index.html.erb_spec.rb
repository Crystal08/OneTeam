require 'spec_helper'

describe "current_skills/index" do
  before(:each) do
    assign(:current_skills, [
      stub_model(CurrentSkill),
      stub_model(CurrentSkill)
    ])
  end

  it "renders a list of current_skills" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
