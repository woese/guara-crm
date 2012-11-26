
require "spreadsheet"

module ActiveMigration
  
  class Migration
  
    def initialize(schema_from_url, schema_to_url)
      self.load_schema_from(schema_from_url)
      self.load_schema_to(schema_to_url)
    end
    
    attr_accessor :schema_from, :schema_to
    
    ##
    # loads yml file and convert to hash on schema_from
    def load_schema_from(url)
      self.schema_from = YAML::load(File.open(url))
    end
    
    ##
    # load yml file and convert to hash on schema_to
    def load_schema_to(url)
      self.schema_to = YAML::load(File.open(url))      
    end
    
    def migrate!
    
      raise "schema_from needs" if @schema_from.nil?
      raise "schema_to needs" if @schema_to.nil?
    
      # TODO: Make flexible configurable
      if @schema_from[:format].to_sym == :XLS
        @xls = Spreadsheet.open @schema_from[:url]
        # TODO: make others workbook accessible by configuration
        sheet = @xls.worksheet 0
      
        @line = 0
      
        # ignore head line
        sheet.each 1 do |row|
          @column = 0
          row_to = { }
          
          #read schema columns and types
          @schema_from[:columns].each do |schema_column, schema_type|
            row_to.merge!(schema_column.to_sym => row[@column])
            @column+=1
          end
        
          #transform row to @schema_to
          raise_migration if !send_row_to_schema(row_to)
          
          @line+=1
        end
      
      end
      
      return true
    
    end
    
    def raise_migration
      raise "failing migration. Line: %d, Column: %d" % [@line, @column]
    end
  
    def send_row_to_schema(row)
      if @schema_to[:format].to_sym == :ACTIVE_RECORD
        class_schema_to = eval @schema_to[:url]
        class_schema_to.new(row).save!
      end
    
    end
  end
  
  class Schema
    ##
    # @attr columns Hash with name and type
    # @attr format Describe data format
    # @attr url define path or object schema
    attr_accessor :columns, :format, :url
    
  end
  
end