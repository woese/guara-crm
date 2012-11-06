require 'spec_helper'

describe "business_departments/show" do
  before(:each) do
    @business_department = assign(:business_department, stub_model(BusinessDepartment,
      :name => "Name",
      :enabled => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/false/)
  end
end
