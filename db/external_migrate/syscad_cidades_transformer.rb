
require "active_migration/transformer/grouped_field_fixed_spelling"
require "active_migration/transformer/dictionary"

class SyscadCidadesTransformer < ActiveMigration::Transformer::GroupedFieldFixedSpelling
  
  include ActiveMigration::Transformer
  include ApplicationHelper
  
  def initialize(schema)
    super schema
    
    @domain_name = "cidades"
    @state_dictionary = ActiveMigration::Transformer::Dictionary.new File.expand_path("../cache/estados_dictionary.yml", __FILE__)
  end
  
  def transform(row)
    Rails.logger.debug "before: "+row.to_yaml
    super row
    
    #convert state entries
    row[:state] = @state_dictionary.find row[:state]
    row[:state] = State.find_by_name(row[:state])
    
    Rails.logger.debug "after: "+row.to_yaml    
  end
  
  def end(schema_from, schema_to)
    super schema_from, schema_to
    Rails.logger.debug @group.to_yaml
  end
  
end