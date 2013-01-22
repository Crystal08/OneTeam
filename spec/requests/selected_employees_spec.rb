require 'spec_helper'

describe "SelectedEmployees" do
  describe "GET /selected_employees" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get selected_employees_path
      response.status.should be(200)
    end
  end
end
