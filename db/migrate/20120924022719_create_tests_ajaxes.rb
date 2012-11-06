class CreateTestsAjaxes < ActiveRecord::Migration
  def change
    create_table :tests_ajaxes do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
