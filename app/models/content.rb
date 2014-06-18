class Content < ActiveRecord::Base

  # has_many :content_videos
  # has_many :videos, through: :content_videos
  has_one :video

  has_many :tag_contents
  has_many :tags, through: :tag_contents

  has_many :bookmarked_contents
  has_many :users, through: :bookmarked_contents

  has_many :user_content
  has_many :users, through: :user_content

  accepts_nested_attributes_for :tags, :video
  validates :title, presence: true

end
