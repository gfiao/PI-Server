class Classroom < ActiveRecord::Base

  has_many :users, through: :free_classrooms

  validate :building, presence: true
  validate :room, presence: true
  validate :room, uniqueness: true

end
