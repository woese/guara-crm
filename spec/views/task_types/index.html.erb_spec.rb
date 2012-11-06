require 'spec_helper'

describe "task_types/index" do
  before(:each) do
    assign(:task_types, [
      stub_model(TaskType,
        :name => "Name"
      ),
      stub_model(TaskType,
        :name => "Name"
      )
    ])
  end

  it "renders a list of task_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
