class CreateCustomerSegments < ActiveRecord::Migration
  def change
    create_table :customer_segments do |t|
      t.integer :customer_pj_id
      t.integer :segment_id
      t.timestamps
    end
  end
end
