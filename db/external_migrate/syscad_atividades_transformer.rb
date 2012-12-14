
require "active_migration/transformer/grouped_field_fixed_spelling"
require "active_migration/dictionary"

class SyscadAtividadesTransformer
  
  include ActiveMigration::Transformer
  include ApplicationHelper
  
  def initialize(schema)
    super schema
    
    @domain_name = "atividades"
    @segmentos_dictionary = ActiveMigration::Transformer::Dictionary.new File.expand_path("../cache/segmentos_dictionary.yml", __FILE__)
    
    @atividades_dictionary = {}
  end
  
  def transform(row)    
    #convert state entries
    row[:business_segment] = @segmentos_dictionary.find row[:business_segment]
    row[:business_segment] = BusinessSegment.find(row[:business_segment]) if (!row[:business_segment].nil? && !row[:business_segment].empty?)
    row.delete :business_segment unless row[:business_segment].is_a? BusinessSegment
    transform_notes row
    true
  end
  
  def transform_notes(row)
    row[:notes] = ActiveMigration::Converters::RtfToHtml.new.parse(row[:notes])
  end
  
  def after_row_saved(row, object)
    unless object.nil?
      @atividades_dictionary[row[:id].to_i.to_s] = object.id
    end
  end
  
  def end(schema_from, schema_to)
    super schema_from, schema_to
    puts_on_file Rails.root.join("db/external_migrate/cache/atividades_dictionary.yml") do
      @atividades_dictionary.to_yaml
    end
  end
  
end