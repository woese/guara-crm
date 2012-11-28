
require File.expand_path("../../spec_helper", __FILE__)

require File.expand_path("../../../active_migration/active_migration", __FILE__)
require File.expand_path("../../../active_migration/migration_schemas", __FILE__)

require File.expand_path('../../support/active_migration_helper', __FILE__)


describe ActiveMigration do
  
  before :all do
    build_config_from()
    build_config_to()
    build_config_schemas()
  end
  
  before do
    @active_migration_schemas = ActiveMigration::MigrationSchemas.new("tmp/schemas.yml")
  end
  
  subject { @active_migration_schemas }
  
  it { should respond_to(:migrate!) }
  
  it { @active_migration_schemas.schemas.should include "test" }
  
  it { @active_migration_schemas.schemas["test"].should include :from => "tmp/file_existing.xls" }
  
  describe "migrate file schemas" do
    before do
      
      build_schemas_tmp_classes()
      
      @result = @active_migration_schemas.migrate!
      puts District.all.to_yaml
    end
    
    it { @result.should be_true }
    it { }
  end
  
  
end