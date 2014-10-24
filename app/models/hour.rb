class Hour < ActiveRecord::Base
	belongs_to :venue
	default_scope -> { order('created_at ASC') }
	#has_many :deals, through: :dealhours
	#has_many :dealhours, foreign_key: :venue_id
end
