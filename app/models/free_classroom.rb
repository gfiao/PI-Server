class FreeClassroom < ActiveRecord::Base

  after_initialize :init

  belongs_to :user
  belongs_to :classroom

  validates :time, presence: true
  validates_associated :user, :classroom
  validates_presence_of :user, :classroom

  def init
    self.likes ||= 1 #will set the default value only if it's nil
  end

end
