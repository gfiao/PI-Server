class Game < ActiveRecord::Base

  has_many :users, through: :scores

  validate :name, presence: true
  validate :name, uniqueness: true

end
