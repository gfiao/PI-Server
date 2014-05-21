class Tag < ActiveRecord::Base

  has_many :tag_contents
  has_many :contents, through: :tag_contents

  validate :tag, presence: true;
  validates_associated :contents

end
