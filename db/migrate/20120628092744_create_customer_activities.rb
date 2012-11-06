class CreateCustomerActivities < ActiveRecord::Migration
  def change
    create_table :customer_activities do |t|
      t.integer :customer_pj_id
      t.integer :activity_id
      t.timestamps
    end
  end
end
