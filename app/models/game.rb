class Game < ActiveRecord::Base

  #has_many :users
  has_many :scores

  validates :name, presence: true
  validates :name, uniqueness: true

end
