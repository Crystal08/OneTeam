require 'spec_helper'

describe "request_skills/index" do
  before(:each) do
    assign(:request_skills, [
      stub_model(RequestSkill,
        :skill_id => 1,
        :request_id => 2
      ),
      stub_model(RequestSkill,
        :skill_id => 1,
        :request_id => 2
      )
    ])
  end

  it "renders a list of request_skills" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
