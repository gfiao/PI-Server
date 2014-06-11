class Score < ActiveRecord::Base

  belongs_to :game
  belongs_to :user

  validates :score, presence: true
  validates_associated :game, :user
  validates_presence_of :game, :user

  validates_uniqueness_of :game_id, :scope => [:user_id]
end
