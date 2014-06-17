class Weather < ActiveRecord::Base

  validates_uniqueness_of :date, :scope => [:min_temp, :max_temp]

end
