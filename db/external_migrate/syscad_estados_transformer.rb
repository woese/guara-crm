
require "active_migration/transformer/grouped_field_fixed_spelling"

class SyscadEstadosTransformer < ActiveMigration::Transformer::GroupedFieldFixedSpelling
  
  include ActiveMigration::Transformer
  include ApplicationHelper
  
  def initialize(schema)
    super schema
    
    @domain_name = "estados"
  end
  
end