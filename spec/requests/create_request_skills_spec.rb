require 'spec_helper'

describe "CreateRequestSkills" do
  describe "GET /create_request_skills" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get create_request_skills_path
      response.status.should be(200)
    end
  end
end
