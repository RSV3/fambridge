class CareReceiver < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  has_many :care_relationships, class_name: "CareRelationship", foreign_key: "receiver_id",
                        dependent: :destroy
end
