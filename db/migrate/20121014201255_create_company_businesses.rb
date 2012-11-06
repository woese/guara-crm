class CreateCompanyBusinesses < ActiveRecord::Migration
  def change
    create_table :company_businesses do |t|
      t.string :name
      t.boolean :enabled

      t.timestamps
    end
  end
end
