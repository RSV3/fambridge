class AddZipcodeToLeadUsers < ActiveRecord::Migration
  def change
    add_column :lead_users, :zipcode, :string, :default => nil
    add_index :lead_users, :zipcode
  end
end
