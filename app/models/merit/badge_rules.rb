# Be sure to restart your server when you modify this file.
#
# +grant_on+ accepts:
# * Nothing (always grants)
# * A block which evaluates to boolean (recieves the object as parameter)
# * A block with a hash composed of methods to run on the target object with
#   expected values (+votes: 5+ for instance).
#
# +grant_on+ can have a +:to+ method name, which called over the target object
# should retrieve the object to badge (could be +:user+, +:self+, +:follower+,
# etc). If it's not defined merit will apply the badge to the user who
# triggered the action (:action_user by default). If it's :itself, it badges
# the created object (new user for instance).
#
# The :temporary option indicates that if the condition doesn't hold but the
# badge is granted, then it's removed. It's false by default (badges are kept
# forever).

module Merit
  class BadgeRules
    include Merit::BadgeRulesMethods

    def initialize
      # If it creates user, grant badge
      # Should be "current_user" after registration for badge to be granted.
      # grant_on 'users#create', badge: 'just-registered', to: :itself

      # If it has 10 comments, grant commenter-10 badge
      # grant_on 'comments#create', badge: 'commenter', level: 10 do |comment|
      #   comment.user.comments.count == 10
      # end

      # If it has 5 votes, grant relevant-commenter badge
      # grant_on 'comments#vote', badge: 'relevant-commenter',
      #   to: :user do |comment|
      #
      #   comment.votes.count == 5
      # end

      # Changes his name by one wider than 4 chars (arbitrary ruby code case)
      # grant_on 'registrations#update', badge: 'autobiographer',
      #   temporary: true, model_name: 'User' do |user|
      #
      #   user.name.length > 4
      # end

      grant_on 'deals#checkin', badge: 'happy-hour-newbie', to: :user, model_name: 'User' do |deal|
        
        deal.user.checkins.count == 1
      end

      grant_on 'deals#checkin', badge: 'adventurer', to: :user, model_name: 'User' do |deal|
        visited = deal.user.checkins.select(:deal_id).map(&:deal_id).uniq
        spots = []
        visited.each do |v|
          spot = Deal.find_by(id: v).venue_id
          unless spots.include?(spot)
            spots << spot
          end
        end
        spots.count == 5
      end

      grant_on 'deals#checkin', badge: 'explorer', to: :user, model_name: 'User' do |deal|
        visited = deal.user.checkins.select(:deal_id).map(&:deal_id).uniq
        spots = []
        visited.each do |v|
          spot = Deal.find_by(id: v).venue_id
          unless spots.include?(spot)
            spots << spot
          end
        end
        spots.count == 15
      end

      grant_on 'deals#checkin', badge: 'bender', to: :user, model_name: 'User' do |deal|
        checkin_dates = []
        checked_dates = [Date.today.to_date, 1.day.ago.to_date, 2.days.ago.to_date, 3.days.ago.to_date ]
        deal.user.checkins.each do |c|
          checkin_dates << c.created_at.to_date
        end
        (checked_dates - checkin_dates).empty?
      end

      grant_on 'deals#checkin', badge: 'pub-crawl', to: :user, model_name: 'User' do |deal|
        checkin_venues = []
        c_time = Time.current
        deal.user.checkins.order(created_at: :desc).each do |d|    
            checkin_venue = Deal.find_by(id: d.deal_id).venue_id
            checkin_time = d.created_at
            unless checkin_venues.include?(checkin_venue)
              checkin_venues << checkin_venue
            end
            if checkin_venues.count == 4
              c_time = checkin_time
            end
        end
          unless  Time.current - c_time < 1.minute
            Time.current - c_time <= 5.hours
          else
            c_time = false
          end
      end


    end
  end
end
