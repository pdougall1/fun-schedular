class Event < ActiveRecord::Base

	belongs_to :user
	# attr_accessor :date, :beginningTime, :endingTime, :name, :location, :latitude, :longitude, :description

end
