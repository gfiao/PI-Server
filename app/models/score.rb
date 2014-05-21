class Score < ActiveRecord::Base

  belongs_to :game
  belongs_to :user

  validate :score, presence: true
  validates_associated :game, :user
  validates_presence_of :game, :user
end
