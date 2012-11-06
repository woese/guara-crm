class AddCompanyBusinessToTaskType < ActiveRecord::Migration
  def change
    add_column :task_types, :company_business_id, :integer
    add_index :task_types, :company_business_id
  end
end
