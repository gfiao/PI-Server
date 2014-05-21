class Classroom < ActiveRecord::Base

  has_many :free_classrooms

  validate :building, presence: true
  validate :classroom, presence: true
  validate :classroom, uniqueness: true

end
