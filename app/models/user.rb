class User < ActiveRecord::Base

  has_many :feeds, foreign_key: "author_id", dependent: :destroy
  has_many :care_receivers, foreign_key: "creator_id", dependent: :destroy
  has_many :care_relationships, foreign_key: "giver_id", dependent: :destroy
  has_many :comments, foreign_key: "writer_id", dependent: :destroy

  has_many :invitations, foreign_key: "giver_id", dependent: :destroy

  before_create :create_remember_token

  before_save do
    self.email = email.downcase 
  end

  validates :first_name, presence: true, length: { maximum: 32 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, 
                    uniqueness: { case_sensitive: false }, 
                    format: { with: VALID_EMAIL_REGEX }

  has_secure_password
  validates :password, length: { minimum: 6 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def myfeed
    Feed.where("author_id = ?", id)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
