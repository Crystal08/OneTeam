require "spec_helper"

describe CurrentSkillsController do
  describe "routing" do

    it "routes to #index" do
      get("/current_skills").should route_to("current_skills#index")
    end

    it "routes to #new" do
      get("/current_skills/new").should route_to("current_skills#new")
    end

    it "routes to #show" do
      get("/current_skills/1").should route_to("current_skills#show", :id => "1")
    end

    it "routes to #edit" do
      get("/current_skills/1/edit").should route_to("current_skills#edit", :id => "1")
    end

    it "routes to #create" do
      post("/current_skills").should route_to("current_skills#create")
    end

    it "routes to #update" do
      put("/current_skills/1").should route_to("current_skills#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/current_skills/1").should route_to("current_skills#destroy", :id => "1")
    end

  end
end
