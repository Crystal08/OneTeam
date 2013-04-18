require "spec_helper"

describe DesiredSkillsController do
  describe "routing" do

    it "routes to #index" do
      get("/desired_skills").should route_to("desired_skills#index")
    end

    it "routes to #new" do
      get("/desired_skills/new").should route_to("desired_skills#new")
    end

    it "routes to #show" do
      get("/desired_skills/1").should route_to("desired_skills#show", :id => "1")
    end

    it "routes to #edit" do
      get("/desired_skills/1/edit").should route_to("desired_skills#edit", :id => "1")
    end

    it "routes to #create" do
      post("/desired_skills").should route_to("desired_skills#create")
    end

    it "routes to #update" do
      put("/desired_skills/1").should route_to("desired_skills#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/desired_skills/1").should route_to("desired_skills#destroy", :id => "1")
    end

  end
end
