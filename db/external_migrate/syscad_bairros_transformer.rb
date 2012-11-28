
class SyscadBairrosTransformer
  
  include ActiveMigration::Transformer
  
  def initialize(schema)
    @schema = schema
    @field_group = :name
    @group = {}
  end
  
  def begin(schema_from, schema_to)
    @group = {}    
  end
  
  def transform(row)
    row[:name] = row[:name_correct] if (!row[:name_correct].nil? && !row[:name_correct].empty?)
    row[:name].gsub! /\s{2,}/, ' '
    @group[row[@field_group]] = row
    :ignore
  end
  
  def end(schema_from, schema_to)
    puts @group.to_yaml
  end
  
end