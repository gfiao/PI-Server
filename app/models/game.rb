class Game < ActiveRecord::Base

  #has_many :users
  has_many :scores

  validate :name, presence: true
  validate :name, uniqueness: true

end
