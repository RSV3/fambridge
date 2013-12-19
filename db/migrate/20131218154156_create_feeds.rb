class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :title
      t.string :content
      t.string :content_type
      t.string :content_img
      t.string :content_url
      t.integer :author_id

      t.timestamps
    end

    add_index :feeds, :created_at 
    add_index :feeds, :content_type
    add_index :feeds, [:author_id, :created_at]
  end
end
