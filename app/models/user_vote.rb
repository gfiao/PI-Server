class UserVote < ActiveRecord::Base

  belongs_to :user
  belongs_to :free_classroom

  validates_uniqueness_of :user_id, :scope => [:free_classroom_id],
                          :message => 'Esta sala já existe'

end
