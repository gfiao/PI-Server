class FreeClassroom < ActiveRecord::Base

  belongs_to :user
  belongs_to :classroom

  validates :time, presence: true
  validates_associated :user, :classroom
  validates_presence_of :user, :classroom

end
