class UserContent < ActiveRecord::Base

  belongs_to :user
  belongs_to :content

  validates_associated :user, :content
end
