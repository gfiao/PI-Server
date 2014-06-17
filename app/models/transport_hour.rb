class TransportHour < ActiveRecord::Base

  belongs_to :transport
  belongs_to :hour

  validates_associated :transport
  validates_associated :hour
end
