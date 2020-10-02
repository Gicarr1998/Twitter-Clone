class Micropost < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 140 }
  default_scope -> { order('created_at DESC')}
  mount_uploader :picture, PictureUploader
end
