class TagContent < ActiveRecord::Base

  belongs_to :content
  belongs_to :tag

  validates_associated :tag, :content
end
