require 'spec_helper'

describe "task_types/edit" do
  before(:each) do
    @task_type = assign(:task_type, stub_model(TaskType,
      :name => "MyString"
    ))
  end

  it "renders the edit task_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => task_types_path(@task_type), :method => "post" do
      assert_select "input#task_type_name", :name => "task_type[name]"
    end
  end
end
