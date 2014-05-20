class Classroom < ActiveRecord::Base

  has_many :users, through: :free_classrooms
end
