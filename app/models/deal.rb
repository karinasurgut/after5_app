class Deal < ActiveRecord::Base
	belongs_to :venue
	validates :venue_id, presence: true
	validates :content, length: { maximum: 140 }
	validates :title, presence: true
	
end
