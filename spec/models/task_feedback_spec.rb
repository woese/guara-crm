require 'spec_helper'

describe TaskFeedback do
  
  let(:task) { Factory(:task, status: SystemTaskStatus.CLOSED, resolution: SystemTaskResolution.RESOLVED) }
  let(:user) { Factory(:user) }
  
  before do
#    able(user, :read, :task)
#    able(user, :update, :task)
#    able(user, :read, :task_feedback)
#    able(user, :update, :task_feedback)
    @task_feedback = TaskFeedback.create(task: task,
                                       date: 1.day.ago,
                                       notes: Faker::Lorem.sentence(7),
                                       user: user,
                                       status: task.status,
                                       resolution: SystemTaskResolution.RESOLVED);
  end
  
  subject { @task_feedback }
  
  it { should respond_to(:task_id) }
  it { should respond_to(:date) }
  it { should respond_to(:notes) }
  it { should respond_to(:user_id) }
  it { should respond_to(:status_id) }
  it { should respond_to(:resolution_id) }
  
  it { should be_valid }
  
  it "feedback should included in task" do
    task.feedbacks.should include(@task_feedback)
  end
  
  describe "not filled required fields" do
    before do
      @task_feedback.notes = ''
      @task_feedback.resolution = nil
    end
    
    it { should be_invalid }
  end
  
  
end
