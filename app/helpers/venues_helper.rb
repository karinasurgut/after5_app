module VenuesHelper
	def distance_to_user(venue)
    if cookies[:lat_lng]
	 @venue.distance_to(cookies[:lat_lng].split("|"), :km).round(2) if venue.geocoded?
  else
    @venue.distance_to([-33.873651,151.2068896], :km).round(2) if venue.geocoded?
	end
  end

	def today_hours(venue)
		today = Date.today.wday
	    today_venue = @venue.hours.find_by(day: today)
	    unless today_venue.closed?
	    	today_open = today_venue.open_time.strftime("%l:%M %p").to_s.downcase!
	    	today_close = today_venue.close_time.strftime("%l:%M %p").to_s.downcase!    
	    	content_tag("span", "Open today #{today_open} to #{today_close}", class: "label label-success", data: { :'toggle' => "collapse", :'target' => "#demo" })
	    else
	    	content_tag("span", "Closed today", class: "label label-danger", data: { :'toggle' => "collapse", :'target' => "#demo" })
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

    def venue_index_title
    	if params[:tag]
	      @pagetitle = "Venues tagged " + params[:tag]
	    else
	      @pagetitle = "All Venues"
	    end  
    end



    def closest_deal
      if cookies[:lat_lng]
        @closest_venues = Venue.near(cookies[:lat_lng].split("|"))
      else
        @closest_venues = Venue.near([-33.873651,151.2068896])
      end
      @closest_venues.each do |v|
      	@v_deals = v.deals.deal_carousel(Date.current.to_date)
      	break @v_deals unless @v_deals.nil?
      end
  	  @v_deals.first
     #  @todaydeals = Deal.deal_carousel(Date.current.to_date)
     #  @tdvenues = {}
     #  @todaydeals.each do |d|
     #  	v = Venue.find(d.venue_id)
     #  	@tdvenues << v
  	  # end
  	  # @tdvenue = @tdvenues.near(cookies[:lat_lng].split("|")).first
     #  @tdvenue.deals.dealcarousel(Date.current.to_date)
    end

end