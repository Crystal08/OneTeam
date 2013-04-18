require 'spec_helper'

describe "create_request_skills/show" do
  before(:each) do
    @create_request_skill = assign(:create_request_skill, stub_model(CreateRequestSkill,
      :skill_id => 1,
      :request_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
