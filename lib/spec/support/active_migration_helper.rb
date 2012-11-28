
####################################
## Migration

def build_config_from()  
    # build schema from
    puts_on_file Rails.root.join("tmp/from.yml") do    
      { columns: { name: "string" },
        format: :XLS,
        url: File.expand_path("../../asserts/sheet1.xls", __FILE__)
      }.to_yaml
    end

end

def build_config_to()
    puts_on_file Rails.root.join("tmp/to.yml") do    
      { columns:
          { name: "string" },
        format: :ACTIVE_RECORD,
        url: "District"
      }.to_yaml
    end
end


#######################################
## Schemas

def build_config_schemas()
  
  puts_on_file "tmp/file_existing.xls" do
    (1..5).map { |n| "line%d" % n }.join("\n")
  end
  
  puts_on_file Rails.root.join("tmp/schemas.yml") do
    
    { "test" => {
        type: :CUSTOM,
        from: "tmp/file_existing.xls",
        to: "District",
        transformer: "MigrationTestDistrictTransformer" 
      },
      "activities" => {
        type: :SCHEMA,
        from: "tmp/from.yml",
        to: "tmp/to.yml",
        transformer: "MigrationActivityTransformer"
      }
    }.to_yaml
  end
end

def build_schemas_tmp_classes()
  eval %q{
    class MigrationTestDistrictTransformer
      include ActiveMigration::Transformer
      
      def initialize(schema)
        
      end
      
      def migrate!
        Rails.logger.info "called MigrationTestDistrictTransformer.migrate!"
        true
      end
      
    end
  }
  
  eval %q{
    class MigrationActivityTransformer
      include ActiveMigration::Transformer
      
      def initialize(schema)
        
      end
      
      def transform(row)
        row[:name] = row[:name] + Time.now.to_s
        true
      end
      
    end
  }
end