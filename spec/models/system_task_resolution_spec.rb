require 'spec_helper'

describe SystemTaskResolution do

  let(:system_task_status) { SystemTaskResolution.RESOLVED }
  
  subject { system_task_status }
  
  it { should respond_to(:name) }

  it { SystemTaskResolution.should respond_to(:RESOLVED) }
  it { SystemTaskResolution.should respond_to(:CANCELED) }
  it { SystemTaskResolution.should respond_to(:BLOCKED) }
    
  it { should be_valid }
  
end
