class CreateCareReceivers < ActiveRecord::Migration
  def change
    create_table :care_receivers do |t|
      t.string :name
      t.integer :creator_id

      t.timestamps
    end

    add_index :care_receivers, [:name, :creator_id], unique: true
  end
end
