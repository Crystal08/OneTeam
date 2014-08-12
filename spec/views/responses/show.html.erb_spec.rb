require 'spec_helper'

describe "responses/show" do
  before(:each) do
    @response = assign(:response, stub_model(Response,
      :request_id => 1,
      :employee_id => 2,
      :comments => "Comments"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Comments/)
  end
end
