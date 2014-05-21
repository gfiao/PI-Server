class ContentVideo < ActiveRecord::Base

  belongs_to :content
  belongs_to :video

  validates_associated :content, :video
  validates_presence_of :content, :video
end
