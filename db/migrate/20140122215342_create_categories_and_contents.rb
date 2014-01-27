class CreateCategoriesAndContents < ActiveRecord::Migration
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

    create_table :categories_contents do |t|
      t.belongs_to :category
      t.belongs_to :content
    end
  end
end
