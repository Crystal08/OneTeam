require 'spec_helper'

describe "selected_employees/index" do
  before(:each) do
    assign(:selected_employees, [
      stub_model(SelectedEmployee,
        : => "",
        : => "",
        : => "",
        : => "",
        : => ""
      ),
      stub_model(SelectedEmployee,
        : => "",
        : => "",
        : => "",
        : => "",
        : => ""
      )
    ])
  end

  it "renders a list of selected_employees" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
