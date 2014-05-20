class Video < ActiveRecord::Base

  has_many :contents, through: :content_videos

  validate :link, presence: true;
end
