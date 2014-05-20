class Classroom < ActiveRecord::Base

  has_many :free_classrooms

  validate :building, presence: true
  validate :room, presence: true
  validate :room, uniqueness: true

end
