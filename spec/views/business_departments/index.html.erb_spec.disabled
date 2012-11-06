require 'spec_helper'

describe "business_departments/index" do
  before(:each) do
    assign(:business_departments, [
      stub_model(BusinessDepartment,
        :name => "Name",
        :enabled => false
      ),
      stub_model(BusinessDepartment,
        :name => "Name",
        :enabled => false
      )
    ])
  end

  it "renders a list of business_departments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
