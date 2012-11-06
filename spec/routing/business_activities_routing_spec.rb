require "spec_helper"

describe BusinessActivitiesController do
  describe "routing" do

    it "routes to #index" do
      get("/business_activities").should route_to("business_activities#index")
    end

    it "routes to #new" do
      get("/business_activities/new").should route_to("business_activities#new")
    end

    it "routes to #show" do
      get("/business_activities/1").should route_to("business_activities#show", :id => "1")
    end

    it "routes to #edit" do
      get("/business_activities/1/edit").should route_to("business_activities#edit", :id => "1")
    end

    it "routes to #create" do
      post("/business_activities").should route_to("business_activities#create")
    end

    it "routes to #update" do
      put("/business_activities/1").should route_to("business_activities#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/business_activities/1").should route_to("business_activities#destroy", :id => "1")
    end

  end
end
