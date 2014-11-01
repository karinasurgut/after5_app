class User < ActiveRecord::Base
  

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable :omniauthable
  acts_as_taggable_on :tags, :interests 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  has_many :checkins
  has_many :deals, through: :checkins
  acts_as_voter
  has_merit
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end

  def totalrateddeals
    self.votes.size
  end

  def checkins_list
    Deal.from_checkins_by(self)
  end
  
  def unique_venues_visited_count
      visited = self.checkins.select(:deal_id).map(&:deal_id).uniq
      spots = []
      visited.each do |v|
        spot = Deal.find_by(id: v).venue_id
        unless spots.include?(spot)
          spots << spot
        end
      end
      spots_count = spots.count
      return spots_count
    end
  def unique_venues_visited
    visited = self.checkins.select(:deal_id).map(&:deal_id).uniq
    spots = []
    visited.each do |v|
      spot = Deal.find_by(id: v).venue_id
      unless spots.include?(spot)
        spots << spot
      end
    end
    spots
  end

  
end