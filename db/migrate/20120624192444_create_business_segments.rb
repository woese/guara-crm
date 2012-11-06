class CreateBusinessSegments < ActiveRecord::Migration
  def change
    create_table :business_segments do |t|
      t.string :name, :limit => 30
      t.boolean :enabled,  :default => true

      t.timestamps
    end
  end
end
