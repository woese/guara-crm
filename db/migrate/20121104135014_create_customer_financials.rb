class CreateCustomerFinancials < ActiveRecord::Migration
  def change
    create_table :customer_financials do |t|
      t.references :customer
      t.boolean  :billing_address_different
      t.integer  :contact_leader_id
      t.boolean :payment_pending
      t.string  :payment_pending_message, :limit => 500
      
      t.references :address
      
      t.string  :notes, :limit => 1000
      
      t.timestamps
    end
  end
end
