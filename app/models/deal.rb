class Deal < ActiveRecord::Base
	belongs_to :venue
	#has_many :dealhours
	#has_many :hours, through: :dealhours
	validates :venue_id, presence: true
	validates :content, length: { maximum: 140 }
	validates :title, presence: true
	
end
