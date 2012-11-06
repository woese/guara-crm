require 'spec_helper'

describe SystemTaskStatus do
  
  let(:system_task_status) { SystemTaskStatus.OPENED }
  
  subject { system_task_status }
  
  it { should respond_to(:name) }

  it { SystemTaskStatus.should respond_to(:OPENED) }
  it { SystemTaskStatus.should respond_to(:IN_PROGRESS) }
  it { SystemTaskStatus.should respond_to(:PAUSED) }
  it { SystemTaskStatus.should respond_to(:CLOSED) }
    
  it { should be_valid }  
end
