class CreateCategoriesContents < ActiveRecord::Migration
  def change
    create_table :categories_contents do |t|
      t.integer :category_id
      t.integer :content_id
    end
  end
end
