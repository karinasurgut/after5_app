class Hour < ActiveRecord::Base
	belongs_to :venue
	#has_many :deals, through: :dealhours
	#has_many :dealhours, foreign_key: :venue_id
end
