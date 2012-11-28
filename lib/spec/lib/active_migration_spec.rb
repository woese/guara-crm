
require File.expand_path("../../spec_helper", __FILE__)

require File.expand_path("../../../active_migration/active_migration", __FILE__)

require File.expand_path('../../support/active_migration_helper', __FILE__)


describe ActiveMigration do
  
  before :all do
    build_config_from()
    build_config_to()
  end
  
  before do
    @active_migration = ActiveMigration::Migration.new("tmp/from.yml", "tmp/to.yml")    
  end
  
  subject { @active_migration }
  
  it { should respond_to(:migrate!) }

  it { should respond_to(:schema_from=) }
  it { should respond_to(:schema_to=) }
  it { should respond_to(:load_schema_from) }
  it { should respond_to(:load_schema_to) }

  
  it { @active_migration.schema_from[:columns].should include(:name => "string") }    
  it { @active_migration.schema_to[:columns].should include(:name => "string") }
  
  
  describe "converting file schema to object schema" do
    describe "schema from" do
      before do
        @active_migration.load_schema_from "tmp/from.yml"
      end
      
      it { @active_migration.schema_from.should include(:columns) }
      it { @active_migration.schema_from[:columns].should include(:name => "string") }
      it { @active_migration.schema_from[:format].should == :XLS }
    end
    
    describe "schema from" do
      before do
        @active_migration.load_schema_to "tmp/to.yml"
      end
      
      it { @active_migration.schema_to.should include(:columns) }
      it { @active_migration.schema_to[:columns].should include(:name => "string") }
      it { @active_migration.schema_to[:format].should == :ACTIVE_RECORD }
    end
    
  end
  
  describe "load XLS to ACTIVE_RECORD" do
    
    describe "load source migration" do
      before do
        @active_migration.should_receive(:send_row_to_schema).exactly(30).and_return(true)
        @result = @active_migration.migrate!
      end
    
      it { @result.should be_true }
    end
    
    describe "load source migration" do
      before do
        @active_migration.should_receive(:send_row_to_schema).exactly(1).and_return(false)
        
      end
    
      it { expect { @result = @active_migration.migrate! }.to raise_error("failing migration. Line: 0, Column: 1") }
    end
    
    
    
  end
  
end