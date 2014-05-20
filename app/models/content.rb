class Content < ActiveRecord::Base

  has_many :videos, through: :content_videos
  has_many :tags, through: :tag_contents
  has_many :users, through: :bookmarked_contents
  has_many :users, through: :user_contents

  validate :title, presence: true;

end
