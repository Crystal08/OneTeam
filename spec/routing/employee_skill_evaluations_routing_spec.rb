require "spec_helper"

describe EmployeeSkillEvaluationsController do
  describe "routing" do

    it "routes to #index" do
      get("/employee_skill_evaluations").should route_to("employee_skill_evaluations#index")
    end

    it "routes to #new" do
      get("/employee_skill_evaluations/new").should route_to("employee_skill_evaluations#new")
    end

    it "routes to #show" do
      get("/employee_skill_evaluations/1").should route_to("employee_skill_evaluations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/employee_skill_evaluations/1/edit").should route_to("employee_skill_evaluations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/employee_skill_evaluations").should route_to("employee_skill_evaluations#create")
    end

    it "routes to #update" do
      put("/employee_skill_evaluations/1").should route_to("employee_skill_evaluations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/employee_skill_evaluations/1").should route_to("employee_skill_evaluations#destroy", :id => "1")
    end

  end
end
