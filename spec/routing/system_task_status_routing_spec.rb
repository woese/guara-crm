require "spec_helper"

describe SystemTaskStatusController do
  describe "routing" do

    it "routes to #index" do
      get("/system_task_status").should route_to("system_task_status#index")
    end

    it "routes to #new" do
      get("/system_task_status/new").should route_to("system_task_status#new")
    end

    it "routes to #show" do
      get("/system_task_status/1").should route_to("system_task_status#show", :id => "1")
    end

    it "routes to #edit" do
      get("/system_task_status/1/edit").should route_to("system_task_status#edit", :id => "1")
    end

    it "routes to #create" do
      post("/system_task_status").should route_to("system_task_status#create")
    end

    it "routes to #update" do
      put("/system_task_status/1").should route_to("system_task_status#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/system_task_status/1").should route_to("system_task_status#destroy", :id => "1")
    end

  end
end
