class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_secure_password
  #Basic validation
  validates :name, presence: true, length: {minimum:5, maximum:50}
  #Validate email
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { minimum:5, maximum:255 },
                                    format: { with: EMAIL_REGEX },
                                    uniqueness: { case_sensitive: false }
  #Validate password
  validates :password, presence: true, length: { minimum:6 }, allow_nil: true

  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  
  has_many :passive_relationships, class_name: "Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy      
                                  
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower


  #follow a user
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end
  #unfollow a user
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  #return true if the current user is following the other user
  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end

  #return a users feeds
  def feed
    Micropost.where("user_id IN (?) OR user_id = ?", following.ids, id)
  end
end
