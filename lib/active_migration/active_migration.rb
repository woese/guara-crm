
require "spreadsheet"
require 'active_support'
require 'ruby-debug'


module ActiveMigration
  
  class Migration
  
    def initialize(schema_from_url, schema_to_url)
      self.load_schema_from(schema_from_url)
      self.load_schema_to(schema_to_url)
    end
    
    attr_accessor :schema_from, :schema_to, :transformer
    
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
    
    
    ##
    # Running migration from configured files
    # 
    # ps> Default Behaviour Ignore First line - assumes head line
    
    def migrate!
    
      raise "schema_from needs" if @schema_from.nil?
      raise "schema_to needs" if @schema_to.nil?
      
      begin_migration()
    
      # TODO: Make flexible configurable
      if @schema_from[:format].to_sym == :XLS
        xls_migrate()   
      end
      
      end_migration()
      
      return true
    
    end
    
    
    def xls_migrate
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
        res = true
        res = @transformer.transform(row_to) if not @transformer.nil?
        
        if (res!=:ignore)
          res = res==true && send_row_to_schema(row_to)
          raise_migration if (res==false)
        end
        
        @line+=1
      end
    end
    
    
    def begin_migration
      # TODO: make transactional
      res = @transformer.begin_transaction(@schema_from, @schema_to) if not @transformer.nil?

      res = @transformer.begin(@schema_from, @schema_to) if not @transformer.nil?
    end
    
    
    def end_migration
      res = @transformer.end(@schema_from, @schema_to) if not @transformer.nil?
      
      # TODO: transactions
      res = @transformer.end_transaction(@schema_from, @schema_to) if not @transformer.nil?
    end
    
    def raise_migration
      raise "failing migration. Line: %d, Column: %d" % [@line, @column]
    end
  
    def send_row_to_schema(row)
      if @schema_to[:format].to_sym == :ACTIVE_RECORD
        
        # TODO: optimize on initialize migration
        class_schema_to = eval @schema_to[:url]
        
        mdl = class_schema_to.new(row)
        res = mdl.save
        
        if (!res)
          raise mdl.errors.to_s
        end
        
        return res
      end
      
      raise "Format not valid!"
    
    end
  end
  
  class Schema
    ##
    # @attr columns Hash with name and type
    # @attr format Describe data format
    # @attr url define path or object schema
    attr_accessor :columns, :format, :url
    
  end
  
  ##
  # Transformation schema
  # When passing to schema
  module Transformer
    ##
    # called on start of migration
    def begin(schema_from, schema_to)
      # nothing      
    end
    
    ##
    # called on start of migration
    def begin_transaction(schema_from, schema_to)
      # nothing
    end
    
    ##
    # transform from data row to destinate data row 
    # @result true, false or :ignore to ignore this row
    def transform(row)
      raise "Implements transform method!"
    end
    
    ##
    # called on ending migration
    def end(schema_from, schema_to)
      # nothing
    end
    
    ##
    # called on ending transaction
    def end_transaction(schema_from, schema_to)
      # nothing
    end
    
  end
  
end