class Deal < ActiveRecord::Base
	belongs_to :venue
	acts_as_votable
	acts_as_taggable
	#has_many :dealhours
	#has_many :hours, through: :dealhours
	validates :venue_id, presence: true
	validates :content, length: { maximum: 140 }
	validates :title, presence: true
	
	def score
		#self.get_upvotes.size - self.get_downvotes.size
		self.get_upvotes.size*10/(self.get_upvotes.size + self.get_downvotes.size).round(2)
	end

	def userlikes
		self.get_likes.size
	end

	def self.from_checkins_by(user)
      #all_checkins = user.checkins.select(:deal_id).map(&:deal_id).uniq
      #all_checkins.each do |deal|
      # d = Deal.find_by(id: deal)
      #render partial: 'deals/deal', locals: {deal: d}
      Deal.find(user.checkins.select(:deal_id).map(&:deal_id).uniq)
    end

end
