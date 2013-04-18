require "spec_helper"

describe RequestSkillsController do
  describe "routing" do

    it "routes to #index" do
      get("/request_skills").should route_to("request_skills#index")
    end

    it "routes to #new" do
      get("/request_skills/new").should route_to("request_skills#new")
    end

    it "routes to #show" do
      get("/request_skills/1").should route_to("request_skills#show", :id => "1")
    end

    it "routes to #edit" do
      get("/request_skills/1/edit").should route_to("request_skills#edit", :id => "1")
    end

    it "routes to #create" do
      post("/request_skills").should route_to("request_skills#create")
    end

    it "routes to #update" do
      put("/request_skills/1").should route_to("request_skills#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/request_skills/1").should route_to("request_skills#destroy", :id => "1")
    end

  end
end
