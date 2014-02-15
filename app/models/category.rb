class Category < ActiveRecord::Base
  has_many :sub_categories, class_name: "Category"
  belongs_to :parent_category, class_name: "Category", foreign_key: "parent_id"
  has_many :contents, class_name: "Content", foreign_key: "main_category_id"
  has_many :contents, class_name: "Content", foreign_key: "sub_category_id"
end
