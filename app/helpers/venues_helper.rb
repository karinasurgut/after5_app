module VenuesHelper
	def distance_to_user(venue)
	 @venue.distance_to(cookies[:lat_lng].split("|"), :km).round(2) if venue.geocoded?
	end

	def today_hours(venue)
		today = Date.today.wday
	    today_venue = @venue.hours.find_by(day: today)
	    unless today_venue.closed?
	    	today_open = today_venue.open_time.strftime("%I:%M %p").to_s.downcase!
	    	today_close = today_venue.close_time.strftime("%I:%M %p").to_s.downcase!    
	    	content_tag("span", "Open today #{today_open} to #{today_close}", class: "label label-success")
	    else
	    	content_tag("span", "Closed today", class: "label label-danger")
	    end
	end
end
