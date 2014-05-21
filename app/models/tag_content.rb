class TagContent < ActiveRecord::Base

  belongs_to :content
  belongs_to :tag


  validates_associated :tag
  validates_associated :content

  validates_presence_of :tag
  validates_presence_of :content
end
