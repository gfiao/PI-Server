class Game < ActiveRecord::Base

  has_many :users, through: :scores
end
