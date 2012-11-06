class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string	:name	, :limit => 60, :null => false
      t.string	:doc	, :limit => 14
      t.string	:doc_rg	, :limit => 22
		
      t.string	:name_sec	, :limit => 40 #
      t.string	:address	, :limit => 80
      t.integer	:district_id
      t.integer	:city_id
      t.integer	:state_id
      t.string	:postal	  , :limit => 8
      t.string	:notes    , :limit => 500
      t.date  	:birthday	
		
      t.string	:phone	        , :limit => 15
      t.string	:social_link	, :limit => 200
      t.string	:site	        , :limit => 200
      t.boolean	:is_customer	, :default => false
      #dont use field name type, its used for inharitance and crashs on restore
      #t.boolean	:type         , :default => true #legal entity or individual
      t.integer	:parent_id
      
      t.boolean :enabled,  :default => true

      t.references :person, :polymorphic => true
      
      t.boolean :complete

      t.timestamps
    end
  end
end
