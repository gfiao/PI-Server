class Menu < ActiveRecord::Base

  validates_uniqueness_of :dish, :scope => [:meal, :restaurant, :date]

end
