class Video < ActiveRecord::Base

  has_many :contents, through: :content_videos

  validates :link, presence: true;
end
