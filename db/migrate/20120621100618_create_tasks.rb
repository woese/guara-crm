class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string     :name, limit: 60
      t.references :interested, :polymorphic => true
      t.references :contact, :polymorphic => true
      t.datetime :due_time
      t.datetime :finish_time
      t.string	:notes, :limit => 140
      t.string :description, :limit => 1000
      
      t.integer	:user_id
      t.integer	:status_id
      t.integer :type_id
      t.integer :assigned_id
      t.integer :resolution_id
      
      t.timestamps
    end
    
    add_index :tasks, [:interested_id, :interested_type]
    add_index :tasks, :status_id
    add_index :tasks, :assigned_id
    add_index :tasks, :type_id
  end
end
