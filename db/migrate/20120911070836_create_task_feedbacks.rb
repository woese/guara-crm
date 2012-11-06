class CreateTaskFeedbacks < ActiveRecord::Migration
  def change
    create_table :task_feedbacks do |t|
      t.integer :task_id
      t.datetime :date
      t.string :notes
      t.integer :user_id
      t.integer :status_id
      t.integer :resolution_id

      t.timestamps
    end
  end
end
