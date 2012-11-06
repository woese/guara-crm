require "spec_helper"

describe Tests::AjaxesController do
  describe "routing" do

    it "routes to #index" do
      get("/tests/ajaxes").should route_to("tests/ajaxes#index")
    end

    it "routes to #new" do
      get("/tests/ajaxes/new").should route_to("tests/ajaxes#new")
    end

    it "routes to #show" do
      get("/tests/ajaxes/1").should route_to("tests/ajaxes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tests/ajaxes/1/edit").should route_to("tests/ajaxes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tests/ajaxes").should route_to("tests/ajaxes#create")
    end

    it "routes to #update" do
      put("/tests/ajaxes/1").should route_to("tests/ajaxes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tests/ajaxes/1").should route_to("tests/ajaxes#destroy", :id => "1")
    end

  end
end
