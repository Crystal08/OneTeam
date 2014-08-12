require 'spec_helper'

describe "current_skills/edit" do
  before(:each) do
    @current_skill = assign(:current_skill, stub_model(CurrentSkill))
  end

  it "renders the edit current_skill form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => current_skills_path(@current_skill), :method => "post" do
    end
  end
end
