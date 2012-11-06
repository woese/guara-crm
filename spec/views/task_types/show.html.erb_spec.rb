require 'spec_helper'

describe "task_types/show" do
  before(:each) do
    @task_type = assign(:task_type, stub_model(TaskType,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
