require 'spec_helper'

describe "selected_employees/show" do
  before(:each) do
    @selected_employee = assign(:selected_employee, stub_model(SelectedEmployee,
      : => "",
      : => "",
      : => "",
      : => "",
      : => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
  end
end
