class Tag < ActiveRecord::Base

  has_many :contents, through: :tag_contents
end
