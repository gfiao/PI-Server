class Video < ActiveRecord::Base

  has_many :contents, through: :content_videos
end
