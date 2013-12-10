class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.boolean :send_weekly_report
      t.boolean :agree_terms
      t.string :profile_photo

      t.timestamps
    end
  end
end
