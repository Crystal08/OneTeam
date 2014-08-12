require 'spec_helper'

describe "responses/index" do
  before(:each) do
    assign(:responses, [
      stub_model(Response,
        :request_id => 1,
        :employee_id => 2,
        :comments => "Comments"
      ),
      stub_model(Response,
        :request_id => 1,
        :employee_id => 2,
        :comments => "Comments"
      )
    ])
  end

  it "renders a list of responses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Comments".to_s, :count => 2
  end
end
