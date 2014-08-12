require 'spec_helper'

describe "request_skills/new" do
  before(:each) do
    assign(:request_skill, stub_model(RequestSkill,
      :skill_id => 1,
      :request_id => 1
    ).as_new_record)
  end

  it "renders new request_skill form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => request_skills_path, :method => "post" do
      assert_select "input#request_skill_skill_id", :name => "request_skill[skill_id]"
      assert_select "input#request_skill_request_id", :name => "request_skill[request_id]"
    end
  end
end
