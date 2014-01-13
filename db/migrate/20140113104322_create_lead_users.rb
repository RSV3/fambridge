class CreateLeadUsers < ActiveRecord::Migration
  def change
    create_table :lead_users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :referrer

      t.timestamps
    end
  end
end
