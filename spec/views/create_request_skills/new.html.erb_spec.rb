require 'spec_helper'

describe "create_request_skills/new" do
  before(:each) do
    assign(:create_request_skill, stub_model(CreateRequestSkill,
      :skill_id => 1,
      :request_id => 1
    ).as_new_record)
  end

  it "renders new create_request_skill form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => create_request_skills_path, :method => "post" do
      assert_select "input#create_request_skill_skill_id", :name => "create_request_skill[skill_id]"
      assert_select "input#create_request_skill_request_id", :name => "create_request_skill[request_id]"
    end
  end
end
