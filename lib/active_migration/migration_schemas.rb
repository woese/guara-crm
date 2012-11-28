
module ActiveMigration
  
  ##
  # Façade class
  # make easy way to running batchs schemas migrations
  #
  # === File Format
  # name_migration:  
  #   :type: CUSTOM, SCHEMA 
  #   from: URL to from schema or Custom Param
  #   to: URL to destinate schema or Custom Param
  #   transformer: class will be called to data transformations
    
  class MigrationSchemas
    
    attr_accessor :transformer, :schemas
    
    def initialize(file_schemas)
      raise "Invalid File: should not null!" if file_schemas.nil?
      raise "Invalid File: should not exists!" if not File.exists?(file_schemas)
      @schemas = YAML::load(File.open(file_schemas))
    end
    

    def eval_class(class_str)
      begin
        class_found = eval class_str
        raise "its %s not a class" % class_str if !class_found.is_a?(Class) 
      rescue
        class_found = false
      end
    end

    def transformer_class=(class_str)
      file_name = class_str.underscore + ".rb"
      
      class_found = eval_class(class_str)
      
      if class_found==false
        require_dependence(file_name)
        class_found = eval_class(class_str)
        raise "Invald informed Transformer. " if class_found == false 
      end
      
      @transformer = (eval class_str).new @schema
    end
    
    def require_dependence(file_name)
      files = []
      
      Rails.logger.warn "Requiring file %s" % file_name
      
      files << file_name
      files << Rails.root.join("db/external_migrate/" + file_name)
      Dir[File.expand_path("**/external_migrate/**/" + file_name)].each { |f| files << f }
      files << "../" + file_name
      files << "../../" + file_name
      Dir[File.expand_path("**/" + file_name)].each { |f| files << f }
      
      files.each do |file|
        if File.exists? file
          Rails.logger.debug "Including file %s" % file
          require file
          break
        end
      end
    end
    
    
    def migrate!
      @schemas.each do |key,schema|
        
        @migration_name = key
        @schema = schema
        
        Rails.logger.info "Starting external migration: %s..." % @migration_name
        
        self.transformer_class = schema[:transformer] if schema.include? :transformer
                
        case schema[:type]
          when :SCHEMA
            result = self.migrate_schema(schema)
          when :CUSTOM
            result = self.migrate_custom(schema)
        end
        
        raise "Failing Migrate Schemas: %s" % key if not result
        
        Rails.logger.info "Ending: %s." % key
      end
    end
    
    def migrate_schema(schema)
      migration = ActiveMigration::Migration.new(schema[:from], schema[:to])
      migration.transformer = @transformer
      migration.migrate!
    end
    
    def migrate_custom(schema)
      
      raise "Transformer not assigned" if @transformer.nil?
      raise "Invalid Custom Migration Transformer" if not @transformer.respond_to?(:migrate!) 
      
      @transformer.migrate!
    end
    
    
  end
end