class CareReceiver < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  # care relationship stores secondary care givers
  has_many :care_relationships, class_name: "CareRelationship", foreign_key: "receiver_id",
                        dependent: :destroy
  has_many :givers, through: :care_relationships
end
