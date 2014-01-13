class AddIndexToLeadUsersEmail < ActiveRecord::Migration
  def change
    add_index :lead_users, :email, unique: true
  end
end
