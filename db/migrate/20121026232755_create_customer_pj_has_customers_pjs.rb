class CreateCustomerPjHasCustomersPjs < ActiveRecord::Migration
  def change
    create_table :customer_pj_has_customers_pjs do |t|
      t.integer :from_id
      t.integer :to_id

      t.timestamps
    end
  end
end
