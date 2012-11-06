class CreateCustomerPjs < ActiveRecord::Migration
  def change
    create_table :customer_pjs do |t|
      t.string	:fax	, :limit => 15
      t.integer	:total_employes	
      t.integer	:segment_id	
      t.integer	:activity_id

      t.timestamps
    end
  end
end
