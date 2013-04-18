require 'spec_helper'

describe "current_skills/show" do
  before(:each) do
    @current_skill = assign(:current_skill, stub_model(CurrentSkill))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
