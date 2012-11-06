require 'spec_helper'

describe "company_businesses/index" do
  before(:each) do
    assign(:company_businesses, [
      stub_model(CompanyBusiness,
        :name => "Name",
        :enabled => false
      ),
      stub_model(CompanyBusiness,
        :name => "Name",
        :enabled => false
      )
    ])
  end

  it "renders a list of company_businesses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
