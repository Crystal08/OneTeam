require 'spec_helper'

describe "current_skills/new" do
  before(:each) do
    assign(:current_skill, stub_model(CurrentSkill).as_new_record)
  end

  it "renders new current_skill form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => current_skills_path, :method => "post" do
    end
  end
end
