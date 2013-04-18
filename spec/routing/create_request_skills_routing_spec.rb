require "spec_helper"

describe CreateRequestSkillsController do
  describe "routing" do

    it "routes to #index" do
      get("/create_request_skills").should route_to("create_request_skills#index")
    end

    it "routes to #new" do
      get("/create_request_skills/new").should route_to("create_request_skills#new")
    end

    it "routes to #show" do
      get("/create_request_skills/1").should route_to("create_request_skills#show", :id => "1")
    end

    it "routes to #edit" do
      get("/create_request_skills/1/edit").should route_to("create_request_skills#edit", :id => "1")
    end

    it "routes to #create" do
      post("/create_request_skills").should route_to("create_request_skills#create")
    end

    it "routes to #update" do
      put("/create_request_skills/1").should route_to("create_request_skills#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/create_request_skills/1").should route_to("create_request_skills#destroy", :id => "1")
    end

  end
end
