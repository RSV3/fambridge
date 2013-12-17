class AddSuperAdminAndPrimaryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :super_admin, :boolean, default: false
    add_column :users, :primary, :boolean, default: false
  end
end
