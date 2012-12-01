
require "active_migration/transformer/grouped_field_fixed_spelling"
require "active_migration/transformer/dictionary"

class SyscadAtividadesTransformer
  
  include ActiveMigration::Transformer
  include ApplicationHelper
  
  def initialize(schema)
    super schema
    
    @domain_name = "atividades"
  end
  
  def transform(row)    
    #convert state entries
    row[:business_segment] = BusinessSegment.find(row[:business_segment]) if (!row[:business_segment].nil? && !row[:business_segment].empty?)
    
    true
  end
  
  def end(schema_from, schema_to)
    super schema_from, schema_to
  end
  
end