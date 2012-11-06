class CreateCustomerPfs < ActiveRecord::Migration
  def change
    create_table :customer_pfs do |t|
      t.string	:gender             , :limit => 1
      t.integer :company
      t.string	:business_address   , :limit => 120
      t.string	:department         , :limit => 20
      t.string	:corporate_function , :limit => 20
      t.string	:cellphone          , :limit => 15
      t.string	:graduated          , :limit => 30
      t.timestamps
    end
  end
end
