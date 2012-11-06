require 'spec_helper'

describe "company_businesses/show" do
  before(:each) do
    @company_business = assign(:company_business, stub_model(CompanyBusiness,
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
