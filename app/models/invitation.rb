class Invitation < ActiveRecord::Base
  belongs_to :giver, class_name: "User"
end
