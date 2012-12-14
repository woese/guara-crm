namespace :db do
  task external_migrate: :environment do
    
    require Rails.root.join("lib/active_migration")
    
    Dir[Rails.root.join("lib/active_migration/*.rb")].each { |file| require file } 
    
    Dir[Rails.root.join("db/external_migrate/*schemas.yml")].each do |file|
      
      @migration_schemas = ActiveMigration::Schemas::SchemasMigration.new file
      
      if @migration_schemas.migrate!
        Rails.logger.info "Migration success! %s" % file
      end
      
    end
    
    
    
  end
  
end