class Transport < ActiveRecord::Base

  has_many :transport_hours
  has_many :hours, through: :transport_hours

  validates :carreira, presence: true
  validates :origin, presence: true
  validates :destination, presence: true
end
