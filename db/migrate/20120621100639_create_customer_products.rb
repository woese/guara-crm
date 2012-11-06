class CreateCustomerProducts < ActiveRecord::Migration
  def change
    create_table :customer_products do |t|
      t.integer	:costumer_id	
      t.integer	:product_id	
      t.date	:date	
      t.boolean	:used	, :default => true
      t.integer	:rate_id


      t.timestamps
    end
  end
end
