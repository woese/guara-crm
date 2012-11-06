require "spec_helper"

describe CompanyBusinessesController do
  describe "routing" do

    it "routes to #index" do
      get("/company_businesses").should route_to("company_businesses#index")
    end

    it "routes to #new" do
      get("/company_businesses/new").should route_to("company_businesses#new")
    end

    it "routes to #show" do
      get("/company_businesses/1").should route_to("company_businesses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/company_businesses/1/edit").should route_to("company_businesses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/company_businesses").should route_to("company_businesses#create")
    end

    it "routes to #update" do
      put("/company_businesses/1").should route_to("company_businesses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/company_businesses/1").should route_to("company_businesses#destroy", :id => "1")
    end

  end
end
