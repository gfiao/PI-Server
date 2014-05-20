class FreeClassroom < ActiveRecord::Base

  belongs_to :user
  belongs_to :classroom

  validate :hour, presence: true
  validates_associated :user, :classroom
end
