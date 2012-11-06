class AddNotesAndOtherContactsToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :other_contacts, :string, :limit => 70
  end
end
