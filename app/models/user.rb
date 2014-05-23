class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :bookmarked_contents
  has_many :contents, through: :bookmarked_contents

  has_many :user_contents
  has_many :contents, through: :user_contents

  has_many :free_classrooms
  #has_many :classrooms, through: :free_classrooms

  has_many :scores
  #has_many :games, through: :scores

  validate :name, presence: true;
  validate :email, presence: true, uniqueness: true
  validate :gender, presence: true;
  validate :birth_date, presence: true;

end
