require 'spec_helper'

describe "selected_employees/edit" do
  before(:each) do
    @selected_employee = assign(:selected_employee, stub_model(SelectedEmployee,
      : => "",
      : => "",
      : => "",
      : => "",
      : => ""
    ))
  end

  it "renders the edit selected_employee form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => selected_employees_path(@selected_employee), :method => "post" do
      assert_select "input#selected_employee_", :name => "selected_employee[]"
      assert_select "input#selected_employee_", :name => "selected_employee[]"
      assert_select "input#selected_employee_", :name => "selected_employee[]"
      assert_select "input#selected_employee_", :name => "selected_employee[]"
      assert_select "input#selected_employee_", :name => "selected_employee[]"
    end
  end
end
