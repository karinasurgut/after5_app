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

	def imagefile_for(venue)
  	  imagefile = @venue.image
    end

    def online_contacts_for(venue)
    	website = @venue.website
    	email = @venue.email
    	web_link = link_to "Website", website, class: "", alt: "#{@venue.name} Website"
    	email_link = mail_to email, "Email", class: "", alt: "Email #{@venue.name}"
    	online_contacts = web_link + " | " + email_link
    end
end
