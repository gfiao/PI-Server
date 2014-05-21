class BookmarkedContent < ActiveRecord::Base

  belongs_to :user
  belongs_to :content

  validates_associated :user, :content
  validates_presence_of :user, :content
end
