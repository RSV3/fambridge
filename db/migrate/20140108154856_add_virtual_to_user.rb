class AddVirtualToUser < ActiveRecord::Migration
  def change
    add_column :users, :virtual, :boolean, :default => false
  end
end
