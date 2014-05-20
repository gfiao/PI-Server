class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :contents, through: :bookmarked_contents
  has_many :contents, through: :user_contents
  has_many :classrooms, through: :free_classrooms
  has_many :games, through: :scores
end
