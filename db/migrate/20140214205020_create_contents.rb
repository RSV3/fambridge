class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :title
      t.string :slug
      t.string :content_type
      t.string :author
      t.references :main_category, index: true
      t.references :sub_category, index: true
      t.boolean :homepage, :default => false
      t.integer :homepage_order, :default => nil
      t.boolean :homepage_highlight, :default => false

      t.timestamps
    end

    add_index :contents, :slug
    add_index :contents, :content_type
    add_index :contents, :author

  end
end
