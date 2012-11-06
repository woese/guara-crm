require 'spec_helper'

describe "business_departments/edit" do
  before(:each) do
    @business_department = assign(:business_department, stub_model(BusinessDepartment,
      :name => "MyString",
      :enabled => false
    ))
  end

  it "renders the edit business_department form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => business_departments_path(@business_department), :method => "post" do
      assert_select "input#business_department_name", :name => "business_department[name]"
      assert_select "input#business_department_enabled", :name => "business_department[enabled]"
    end
  end
end
