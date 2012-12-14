# encoding: utf-8
require "active_migration/transformer/grouped_field_fixed_spelling"
require "active_migration/dictionary"

class SyscadClientesAtividadesTransformer
  
  include ActiveMigration::Transformer
  include ApplicationHelper
  
  def initialize(schema)
    super schema
    
    @domain_name = "clientes_atividades"
    @atividades_dictionary = ActiveMigration::Transformer::Dictionary.new File.expand_path("../cache/atividades_dictionary.yml", __FILE__)
  end
  
  def transform(row)    
    #convert state entries
    customer = Customer.find_by_external_key row.delete :customer
    return :ignore if customer.nil?
    
    row[:customer_pj] = customer.person
    row[:activity_id] = @atividades_dictionary.find(row[:activity_id])

    unless BusinessAcitivity.find_by_id row[:activity_id]
      Rails.logger.debug "Não é uma atividade válida! %s" % row[:activity_id].to_s
      return :ignore
    end
    
    true
  end
  
  def end(schema_from, schema_to)
    super schema_from, schema_to
  end
  
end