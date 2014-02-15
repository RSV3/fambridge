class Content < ActiveRecord::Base
  belongs_to :main_category, class_name: "Category"
  belongs_to :sub_category, class_name: "Category"
end
