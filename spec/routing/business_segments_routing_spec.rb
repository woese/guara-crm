require "spec_helper"

describe BusinessSegmentsController do
  describe "routing" do

    it "routes to #index" do
      get("/business_segments").should route_to("business_segments#index")
    end

    it "routes to #new" do
      get("/business_segments/new").should route_to("business_segments#new")
    end

    it "routes to #show" do
      get("/business_segments/1").should route_to("business_segments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/business_segments/1/edit").should route_to("business_segments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/business_segments").should route_to("business_segments#create")
    end

    it "routes to #update" do
      put("/business_segments/1").should route_to("business_segments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/business_segments/1").should route_to("business_segments#destroy", :id => "1")
    end

  end
end
