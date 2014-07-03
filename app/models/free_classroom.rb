class FreeClassroom < ActiveRecord::Base

  after_initialize :init
  validate :validate_end_date_before_start_date

  has_many :user_votes
  has_many :users, through: :user_likes

  belongs_to :user
  belongs_to :classroom

  validates :from_time, :to_time, presence: true
  validates_associated :user, :classroom
  validates_presence_of :user, :classroom

  validates_uniqueness_of :classroom_id, :scope => [:from_time, :to_time],
                          :message => 'Esta sala já existe'

  def validate_end_date_before_start_date
    if from_time && to_time
      errors.add(:to_time, "Data de inicio tem de ser menor que a data de fim.") if to_time < from_time
    end
  end

  def init
    self.likes ||= 1 #will set the default value only if it's nil
  end

end
