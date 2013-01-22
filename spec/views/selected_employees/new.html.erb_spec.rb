require 'spec_helper'

describe "selected_employees/new" do
  before(:each) do
    assign(:selected_employee, stub_model(SelectedEmployee,
      : => "",
      : => "",
      : => "",
      : => "",
      : => ""
    ).as_new_record)
  end

  it "renders new selected_employee form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => selected_employees_path, :method => "post" do
      assert_select "input#selected_employee_", :name => "selected_employee[]"
      assert_select "input#selected_employee_", :name => "selected_employee[]"
      assert_select "input#selected_employee_", :name => "selected_employee[]"
      assert_select "input#selected_employee_", :name => "selected_employee[]"
      assert_select "input#selected_employee_", :name => "selected_employee[]"
    end
  end
end
