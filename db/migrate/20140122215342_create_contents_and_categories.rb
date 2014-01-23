class CreateContentsAndCategories < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :title
      t.text :summary
      t.string :url
      t.boolean :recent, default: false
      t.boolean :important, default: false

      t.timestamps
    end

    create_table :categories do |t|
      t.string :name

      t.timestamps
    end

    create_table :contents_categories do |t|
      t.belongs_to :content
      t.belongs_to :category
    end
  end
end
