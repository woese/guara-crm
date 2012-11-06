require "spec_helper"

describe BusinessDepartmentsController do
  describe "routing" do

    it "routes to #index" do
      get("/business_departments").should route_to("business_departments#index")
    end

    it "routes to #new" do
      get("/business_departments/new").should route_to("business_departments#new")
    end

    it "routes to #show" do
      get("/business_departments/1").should route_to("business_departments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/business_departments/1/edit").should route_to("business_departments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/business_departments").should route_to("business_departments#create")
    end

    it "routes to #update" do
      put("/business_departments/1").should route_to("business_departments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/business_departments/1").should route_to("business_departments#destroy", :id => "1")
    end

  end
end
