class AddParentIdToSystemTaskResolution < ActiveRecord::Migration
  def change
    add_column :system_task_resolutions, :parent_id, :integer
  end
end
