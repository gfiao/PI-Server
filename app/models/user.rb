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

  validates :name, presence: true;
  validates :email, presence: true, uniqueness: true
  validates :gender, presence: true;
  validates :course, presence: true;
  validates :birth_date, presence: true;

  has_attached_file :avatar, :styles => {:medium => "300x300>",
                                         :thumb => "100x100>"}, :default_url => "/images/:style/fct.gif"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

end
