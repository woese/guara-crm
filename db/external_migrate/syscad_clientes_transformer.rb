
require "active_migration/transformer/grouped_field_fixed_spelling"
require "active_migration/transformer/dictionary"

class SyscadClientesTransformer
  
  include ActiveMigration::Transformer
  include ApplicationHelper
  
  def initialize(schema)
    super schema
    
    @domain_name = "clientes"
    
    @district_dictionary = ActiveMigration::Transformer::Dictionary.new File.expand_path("../cache/bairros_dictionary.yml", __FILE__)
    @state_dictionary = ActiveMigration::Transformer::Dictionary.new File.expand_path("../cache/estados_dictionary.yml", __FILE__)
    @city_dictionary = ActiveMigration::Transformer::Dictionary.new File.expand_path("../cache/cidades_dictionary.yml", __FILE__)
  end
  
  def transform(row)
    
    #customer_pj
    transform_customer_pj row
    #
    transform_contacts row
    
    row[:notes] = '' if row[:notes].nil?
    
    #
    unless row[:cel_ADD_TO_NOTES].nil?
      row[:notes].concat("\nCelular: "+row.delete(:cel_ADD_TO_NOTES))
    else
      row.delete :cel_ADD_TO_NOTES
    end
    
    unless row[:obs_ADD_TO_NOTES].nil?    
      row[:notes].concat("\n"+row.delete(:obs_ADD_TO_NOTES)) if not row[:obs_ADD_TO_NOTES].nil?
    else
      row.delete :obs_ADD_TO_NOTES
    end
    
    #convert state entries
    state = row.delete :state_name
    state = @state_dictionary.find state
    state = State.find_by_acronym(state)
    
    #convert state entries
    w = {}
    city = row.delete :city_name
    city = @city_dictionary.find city
    city = City.where(name: city, state_id: nil_or_id(state)).first
    
    #district
    district = @district_dictionary.find row.delete(:district_name)
    row[:district] = District.where(name: district, city_id: nil_or_id(city)).first
    
    #email
    email = row.delete :emails_email
    row[:emails] = [{ :email => email }] unless email.nil?
    
    #delete ignore
    row.delete :ignore!
    
    create_customer row
    
    :ignore
  end
  
  def transform_contacts(row)
    row[:contacts] = []
    1..8.times do |n|
      unless (row[("contacts_%d_name" % n).to_sym].nil?)
        contact = {}
        contact[:name]              = row[("contacts_%d_name" % n).to_sym]
        contact[:phone]             = row[("contacts_%d_phone" % n).to_sym]
        contact[:cell]              = row[("contacts_%d_cell" % n).to_sym]
        contact[:business_function] = row[("contacts_%d_business_function" % n).to_sym]
        contact[:birthday]          = row[("contacts_%d_birthday" % n).to_sym]
        
        contact[:emails]            = []
        contact[:emails] << Email.new(email: row[("contacts_%d_email" % n).to_sym]) unless row[("contacts_%d_email" % n).to_sym].nil?
        
        row[:contacts] << Contact.new(contact)
      end
      
      row.delete ("contacts_%d_name" % n).to_sym   
      row.delete ("contacts_%d_phone" % n).to_sym
      row.delete ("contacts_%d_cell" % n).to_sym
      row.delete ("contacts_%d_email" % n).to_sym
      row.delete ("contacts_%d_business_function" % n).to_sym
      row.delete ("contacts_%d_birthday" % n).to_sym
    end
  end
  
  def transform_customer_pj(row)
    row[:customer_pj] = {}
    
    #segment
    segment = row.delete :segment
    row[:customer_pj][:segments] = []
    row[:customer_pj][:segments] << BusinessSegment.find(segment) if (!segment.nil? && !segment.empty?)
    
    #segment
    segment = row.delete :activity
    row[:customer_pj][:activities] = []
    row[:customer_pj][:activities] << BusinessActivity.find(row[:activity]) if (!row[:activity].nil? && !row[:activity].empty?)
    
    #
    row[:customer_pj][:annual_revenues] = row.delete :annual_revenues
    row[:notes].concat("\nClasse: "+row.delete(:class)) if row.delete(:class)
    row[:is_customer] = (row[:is_customer].to_i == 1)
    
    #total_employes
    total_employes = row.delete :customer_pj_total_employes
    row[:customer_pj][:total_employes] = total_employes
    
    row[:customer_pj][:fax] = row.delete :fax
    
  end
  
  def nil_or_id obj
    if obj.nil?
      nil
    else
      obj.id
    end
  end
  
  def create_customer(row)
    
    #customer_pj = row[:customer_pj]
    #contacts    = row[:contacts]
    #segments    = row[:segments]
    #activities  = row[:activities]
    
    customer_pj = row.delete :customer_pj
    contacts    = row.delete :contacts
    
    #segments    = row.delete :segments
    #activities  = row.delete :activities
    
    @customer   = Customer.new(row)
    @person     = CustomerPj.new(customer_pj)
    @customer.person   = @person
    
    #complete valid? 
    @customer.complete = true
    @customer.complete = @customer.valid?
    
    #@person.activities = activities   if activities.count>0
    #@person.segments   = segments     if segments.count>0
    #
    @customer.contacts = contacts     if contacts.count>0
    
    #still valid?
    @customer.complete &&= @customer.valid?
    
    unless @customer.save
      raise StandardError.new "Error ao salvar registro. %s" % @customer.errors.to_yaml
    end
    true
  end
  
  def end(schema_from, schema_to)
    super schema_from, schema_to
  end
  
end