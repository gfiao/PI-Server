class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :contents, through: :bookmarked_contents
  has_many :contents, through: :user_contents
  has_many :free_classrooms
  has_many :games, through: :scores

  validate :name, presence: true;
  validate :gender, presence: true;
  validate :birth_date, presence: true;

end
