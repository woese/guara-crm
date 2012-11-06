require 'spec_helper'

describe UsersHelper do
  
  include Devise::TestHelpers
  
  before do
    @user = Factory(:user) 
    sign_in @user
  end
  
  describe "List Task Types for user" do
    before do
      @user.primary_company_business = Factory(:company_business)
      @user.save!
      @another_company_business = Factory(:company_business)
     
      @tasks_types_to_include = []
      2.times { @tasks_types_to_include << Factory(:task_type, company_business:@user.primary_company_business) }
     
      @tasks_types_not_include = []
      2.times { @tasks_types_not_include << Factory(:task_type, company_business:@another_company_business) }
    end
    
    it "should list only task types for user primary company business" do
      @tasks_types_to_include.each { |tasks_types| helper.task_types_for_current_user().should include(tasks_types) } 
      @tasks_types_not_include.each { |tasks_types| helper.task_types_for_current_user().should_not include(tasks_types) } 
    end
  end
  
  
end