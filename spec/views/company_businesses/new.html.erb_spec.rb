require 'spec_helper'

describe "company_businesses/new" do
  before(:each) do
    assign(:company_business, stub_model(CompanyBusiness,
      :name => "MyString",
      :enabled => false
    ).as_new_record)
  end

  it "renders new company_business form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => company_businesses_path, :method => "post" do
      assert_select "input#company_business_name", :name => "company_business[name]"
      assert_select "input#company_business_enabled", :name => "company_business[enabled]"
    end
  end
end
