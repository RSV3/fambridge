class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :email
      t.string :personal_msg
      t.integer :giver_id
      t.integer :receiver_id

      t.timestamps
    end

    add_index :invitations, :email
    add_index :invitations, :giver_id
    add_index :invitations, :receiver_id
  end
end
