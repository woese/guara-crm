class CreateBusinessDepartments < ActiveRecord::Migration
  def change
    create_table :business_departments do |t|
      t.string :name
      t.boolean :enabled

      t.timestamps
    end
  end
end
