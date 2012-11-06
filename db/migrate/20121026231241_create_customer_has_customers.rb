class CreateCustomerHasCustomers < ActiveRecord::Migration
  def change
    create_table :customer_has_customers do |t|
      t.integer :from_id
      t.integer :to_id

      t.timestamps
    end
  end
end
