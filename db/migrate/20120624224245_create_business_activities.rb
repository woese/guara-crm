class CreateBusinessActivities < ActiveRecord::Migration
  def change
    create_table :business_activities do |t|
      t.string :name, :limit => 100
      t.boolean :enabled,  :default => true
      t.references :business_segment
      t.timestamps
    end
    
    add_index :business_activities, :business_segment_id
  end
end
