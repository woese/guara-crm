require "spec_helper"

describe TaskTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/task_types").should route_to("task_types#index")
    end

    it "routes to #new" do
      get("/task_types/new").should route_to("task_types#new")
    end

    it "routes to #show" do
      get("/task_types/1").should route_to("task_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/task_types/1/edit").should route_to("task_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/task_types").should route_to("task_types#create")
    end

    it "routes to #update" do
      put("/task_types/1").should route_to("task_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/task_types/1").should route_to("task_types#destroy", :id => "1")
    end

  end
end
