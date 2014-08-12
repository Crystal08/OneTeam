require 'spec_helper'

describe "offices/new" do
  before(:each) do
    assign(:office, stub_model(Office,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new office form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => offices_path, :method => "post" do
      assert_select "input#office_name", :name => "office[name]"
    end
  end
end
