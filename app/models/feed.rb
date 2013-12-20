class Feed < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  has_many :comments, dependent: :destroy

  validates :author_id, presence: true
  validates :title, length: { maximum: 200 }
  validates :content, presence: true, length: { minimum: 10 }

  default_scope -> { order('created_at DESC') }
end
