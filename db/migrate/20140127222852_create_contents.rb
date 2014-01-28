class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :title
      t.text :summary
      t.string :slug
      t.string :url
      t.boolean :recent, :default => false
      t.boolean :important, :default => false

      t.timestamps
    end

    add_index :contents, :slug

  end
end
