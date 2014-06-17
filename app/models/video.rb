class Video < ActiveRecord::Base

  # has_many :contents, through: :content_videos
  belongs_to :content

  validates :link, presence: true;
end
