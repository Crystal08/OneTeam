require "spec_helper"

describe SelectedEmployeesController do
  describe "routing" do

    it "routes to #index" do
      get("/selected_employees").should route_to("selected_employees#index")
    end

    it "routes to #new" do
      get("/selected_employees/new").should route_to("selected_employees#new")
    end

    it "routes to #show" do
      get("/selected_employees/1").should route_to("selected_employees#show", :id => "1")
    end

    it "routes to #edit" do
      get("/selected_employees/1/edit").should route_to("selected_employees#edit", :id => "1")
    end

    it "routes to #create" do
      post("/selected_employees").should route_to("selected_employees#create")
    end

    it "routes to #update" do
      put("/selected_employees/1").should route_to("selected_employees#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/selected_employees/1").should route_to("selected_employees#destroy", :id => "1")
    end

  end
end
