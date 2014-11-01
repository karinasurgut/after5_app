class Deal < ActiveRecord::Base
	belongs_to :venue
	has_many :durations, dependent: :destroy, foreign_key: "deal_id"
	has_many :checkins
	accepts_nested_attributes_for :durations, allow_destroy: true,
								  #:reject_if => :attributes_nil?
								  :reject_if => lambda { |a| ( a['from_time(4i)'].blank? == a[:all_day].to_i.zero? ) }#, limit: 7
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

    def user
      @user = self.checkins.last.user
      return @user
    end

    def self.deal_carousel(day)
  	@feed = []
  	Deal.all.each do |deal| 
	  	if (deal.start_date == deal.end_date) && (deal.start_date.to_date == day.to_date)
	  		@feed << deal
	  	else
		  if deal.end_date.nil?	|| (deal.end_date.to_date - day.to_date).to_i >= 0
		  	if ((deal.start_date.to_date - Time.now.to_date).to_i < 0) && !(deal.durations.find_by(week_day: day.to_date.wday).nil?)
			  @feed << deal
			end
		  end
	  	end	
	end
  end

    # def attributes_nil?(attrs)

    # 	r1 = !attrs[:from_time].nil?
    # 	r2 = attrs[:all_day]
    # 	r1 == r2
    # end
end