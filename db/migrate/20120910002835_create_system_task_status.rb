class CreateSystemTaskStatus < ActiveRecord::Migration
  def change
    create_table :system_task_status do |t|
      t.string :name
    end
  end
end
