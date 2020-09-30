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
end
