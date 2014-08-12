require 'spec_helper'

describe "responses/new" do
  before(:each) do
    assign(:response, stub_model(Response,
      :request_id => 1,
      :employee_id => 1,
      :comments => "MyString"
    ).as_new_record)
  end

  it "renders new response form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => responses_path, :method => "post" do
      assert_select "input#response_request_id", :name => "response[request_id]"
      assert_select "input#response_employee_id", :name => "response[employee_id]"
      assert_select "input#response_comments", :name => "response[comments]"
    end
  end
end
