class Content < ActiveRecord::Base

  has_many :content_videos
  has_many :videos, through: :content_videos

  has_many :tag_contents
  has_many :tags, through: :tag_contents

  has_many :bookmarked_contents
  has_many :users, through: :bookmarked_contents

  has_many :users

  validates :title, presence: true;

end
