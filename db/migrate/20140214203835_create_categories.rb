class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :slug
      t.integer :parent_id, :default => nil

      t.timestamps
    end

    add_index :categories, :name
    add_index :categories, :parent_id
    add_index :categories, :slug

  end
end
