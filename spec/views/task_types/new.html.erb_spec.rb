require 'spec_helper'

describe "task_types/new" do
  before(:each) do
    assign(:task_type, stub_model(TaskType,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new task_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => task_types_path, :method => "post" do
      assert_select "input#task_type_name", :name => "task_type[name]"
    end
  end
end
