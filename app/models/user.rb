class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :bookmarked_contents
  has_many :contents, through: :bookmarked_contents

  has_many :content

  has_many :free_classrooms
  #has_many :classrooms, through: :free_classrooms

  has_many :scores
  #has_many :games, through: :scores

  validates :name, presence: true;
  validates :email, presence: true, uniqueness: true
  validates :gender, presence: true;
  validates :course, presence: true;
  validates :birth_date, presence: true;

  # validates_format_of :avatar_url, :presence => true, :with => %r{\.(png|jpg|jpeg|gif|bmp)$}i,
  #                     :message => "needs to be .jpg, .png, .jpeg, .gif, .bmp", :multiline => true

end
