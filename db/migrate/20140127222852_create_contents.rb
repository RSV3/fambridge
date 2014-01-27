class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :title
      t.text :summary
      t.string :slug
      t.string :url
      t.boolean :recent
      t.boolean :important

      t.timestamps
    end

    add_index :contents, :slug

  end
end
