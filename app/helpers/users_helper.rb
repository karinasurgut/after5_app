module UsersHelper

  def userpic_for(user, type="small")
  	#options: small square normal large
  	userpic = user.image.split("=")[0] << "=#{type}"
    link_to image_tag(userpic, alt: user.name, class: "img-circle userpic"), user_path(user)
  end

  def first_name_for(user)
    first_name = user.name.split[0..0].join("")
  end

  def cur_location
    cur_location = cookies[:cur_geo]
  end 

  def unique_venues_visited(user)
    visited = user.checkins.select(:deal_id).map(&:deal_id).uniq
    spots = []
    visited.each do |v|
      spot = Deal.find_by(id: v).venue_id
      unless spots.include?(spot)
        spots << spot
      end
    end
    spots
  end

  def unique_venues_visited_count(user)
    spots = unique_venues_visited(user)
    spots.count
  end

end
