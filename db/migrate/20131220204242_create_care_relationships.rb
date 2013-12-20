class CreateCareRelationships < ActiveRecord::Migration
  def change
    create_table :care_relationships do |t|
      t.integer :giver_id
      t.integer :receiver_id
      t.boolean :primary

      t.timestamps
    end

    add_index :care_relationships, :giver_id
    add_index :care_relationships, :receiver_id
    add_index :care_relationships, [:giver_id, :receiver_id], unique: true
  end
end
