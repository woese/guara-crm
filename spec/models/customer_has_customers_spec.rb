require 'spec_helper'

describe CustomerHasCustomers do
  
  before do
    @customer_has_customers = CustomerHasCustomers.new from: Factory(:customer_pj),
                                                       to:   Factory(:customer_pj)
    
  end
  
  subject { @customer_has_customers }
  
  it { should respond_to(:from) }
  it { should respond_to(:to) }
  its(:from) { should  be_a(Customer) }
  its(:to) { should  be_a(Customer) }
  
end
