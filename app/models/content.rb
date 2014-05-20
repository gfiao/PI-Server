class Content < ActiveRecord::Base

  has_many :content_videos
  has_many :tag_contents
  has_many :bookmarked_contents
  has_many :user_contents
end
