class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :customer
      t.string :name, limit: 40
      t.integer :department_id
      t.string :business_function
      t.string :phone
      t.string :cell
      t.string :birthday

      t.timestamps
    end
    
    add_index :contacts, :customer_id
    add_index :contacts, :department_id
  end
end
