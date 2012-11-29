
require "active_migration/transformer/grouped_field_fixed_spelling"

class SyscadBairrosTransformer < ActiveMigration::Transformer::GroupedFieldFixedSpelling
  
  include ActiveMigration::Transformer
  include ApplicationHelper
  
  def initialize(schema)
    super schema
    
    @domain_name = "bairros"
  end
  
end