require 'spec_helper'

describe TaskType do

  let(:type) { TaskType.new(name: Faker::Name.first_name) }
  
  subject { type }
  
  it { should respond_to(:name) }
  it { should respond_to(:company_business)}
  it { should be_valid }

  it { TaskType.should respond_to(:for_business)}

  
  describe "Company Business" do
    before do
      type.company_business = Factory(:company_business)
      @another = Factory(:company_business)
      type.save!
    end
    
    it { TaskType.for_business(type.company_business).should include(type) }
    it { TaskType.for_business(@another).should_not include(type) }
  end
  
end
