require 'spec_helper'

describe Task do
  
  
  before(:all) { clear_test_dummy }
  
  let(:customer_pj) { FactoryGirl.create(:customer_pj) }
  let(:contact) { FactoryGirl.create(:contact, customer: customer_pj.customer) }
  let(:user) { user = FactoryGirl.create(:user) }
  
  before do
    
    @task = Task.create(name: "task "+Faker::Lorem.sentence(4)[0..52],
                       interested: customer_pj,
                       contact: contact,
                       user: user,
                       assigned: user,
                       notes: Faker::Lorem.sentence(60)[0..139],
                       description: Faker::Lorem.sentence(140)[0..999],
                       due_time: Date.today + 10.days,
                       finish_time: nil,
                       status: SystemTaskStatus.OPENED,
                       resolution: nil,
                       type: FactoryGirl.create(:task_type)
                       )
    
  end
  
  subject { @task }
  
  it { should respond_to(:interested) }
  it { should respond_to(:name) }
  it { should respond_to(:contact) }
  it { should respond_to(:user) }
  it { should respond_to(:assigned) }
  it { should respond_to(:notes) }
  it { should respond_to(:description) }  
  it { should respond_to(:due_time) }
  it { should respond_to(:finish_time) }
  it { should respond_to(:status) }
  it { should respond_to(:resolution) }
  it { should respond_to(:type) }
  it { should respond_to(:assigned) }
  it { should respond_to(:feedbacks) }
  
  it { should respond_to(:done?) }
  it { should respond_to(:done) }
  it { should respond_to(:due_critical_level) }
  
  it { should be_valid }
  
  describe "specials accessible fields" do
    it "attr user must be accessible" do
      expect do
        @task.user = nil
      end.to_not raise_error(ActiveModel::MassAssignmentSecurity::Error)  
    end
    
    it "attr status must be accessible" do
      expect do
        @task.status = nil
      end.to_not raise_error(ActiveModel::MassAssignmentSecurity::Error)  
    end
  end  
    
  describe "required fields must be checked" do
    before do
       @task.status = SystemTaskStatus.CLOSED
       @task.resolution = SystemTaskResolution.RESOLVED
    end
    
    describe "and invalid status equals nil" do
      before { @task.status = nil }
      it { should be_invalid }
    end
    
    describe "and invalid user equals nil" do
      before { @task.user = nil }
      it { should be_invalid }
    end
    
    describe "invalid status for RESOLVED and OPENED" do
      before { @task.status = SystemTaskStatus.OPENED }
      it { should be_invalid }
    end
    
    describe "invalid notes is empty" do
      before { @task.notes = '' }
      it { should be_invalid }
    end
    
    describe "invalid name" do
      before { @task.name = 'a' }
      it { should be_invalid }
    end
    
    describe "empty name" do
      before { @task.name = '' }
      it { should be_invalid }
    end
    
    describe "empty status is invalid" do
      before do
        @task.status = nil
      end

      it { should be_invalid }
    end
  end
  
  describe "is done and valid" do
    before do
      @task.resolution = SystemTaskResolution.RESOLVED
      @task.status = SystemTaskStatus.CLOSED
    end
    
    it { should be_valid }
  end
  
  
  describe "STATUS is OPENED and resolution is not valid" do
    before { @task.status = SystemTaskStatus.OPENED }
    
    describe "try RESOLVED resolution" do
      before { @task.resolution = SystemTaskResolution.RESOLVED }
      it { should be_invalid }
    end
  
    describe "try CANCELED resolution" do
      before { @task.resolution = SystemTaskResolution.CANCELED }
      it { should be_invalid }
    end  
  
  
    describe "try BLOCKED resolution" do
      before { @task.resolution = SystemTaskResolution.BLOCKED }
      it { should be_invalid }
    end
  end
  
  describe "associated with a CUSTOMER destroyed, must also be destroyed" do
    it { expect { customer_pj.customer.destroy_fully }.to change{ Task.count }.by(-1*customer_pj.customer.tasks.count) }
  end
  
  it "STATUS is CLOSE" do
    @task.status = SystemTaskStatus.CLOSED
    should be_done
  end
  
  describe "due time ending" do
    
    it "overdue" do
      @task.due_time = 2.days.ago
      @task.due_critical_level.should be(3)
    end
    
    it "4 days remain its critical, level is 2" do
      @task.due_time = Time.now + 3.days
      @task.due_critical_level.should be(2)
    end
    
    it "Long time remaining, critical level 1" do
      @task.due_time = Time.now + 200.days
      @task.due_critical_level.should be(1)
    end
    
    
    it "and tasks is done, critical level is 0" do
      @task.due_time = 2.days.ago
      @task.done
      @task.due_critical_level.should be(0)
    end
  end

end
