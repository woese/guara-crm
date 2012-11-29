
require "active_migration/transformer/grouped_field_fixed_spelling"

class SyscadBairrosTransformer < ActiveMigration::Transformer::GroupedFieldFixedSpelling
  
  include ActiveMigration::Transformer
  include ApplicationHelper
  
  def initialize(schema)
    super schema
    
    @domain_name = "bairros"
    @state_dictionary = ActiveMigration::Transformer::Dictionary.new File.expand_path("../cache/estados_dictionary.yml", __FILE__)
    @city_dictionary = ActiveMigration::Transformer::Dictionary.new File.expand_path("../cache/estados_dictionary.yml", __FILE__)
  end

    def transform(row)
      Rails.logger.debug "before: "+row.to_yaml
      super row
      
      # @TODO: insert state information
      #convert state entries
      #row[:state] = @state_dictionary.find row[:state]
      #row[:state] = State.find_by_name(row[:state])
      
      #convert state entries
      row[:city] = @city_dictionary.find row[:city]
      row[:city] = City.where(name: row[:city]).first
      
      Rails.logger.debug "after: "+row.to_yaml    
    end

    def end(schema_from, schema_to)
      super schema_from, schema_to
      Rails.logger.debug @group.to_yaml
    end
  
end