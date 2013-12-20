class Comment < ActiveRecord::Base
  belongs_to :writer, class_name: "User"
  belongs_to :feed, class_name: "Feed"
end
