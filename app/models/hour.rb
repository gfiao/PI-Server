class Hour < ActiveRecord::Base

  has_many :transport_hours
  has_many :transports, through: :transport_hours

  validates :hour, presence: true
  validates :minute, presence: true
end
