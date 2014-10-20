module VenuesHelper
	def distance_to_user(venue)
	 @venue.distance_to(cookies[:lat_lng].split("|"), :km).round(2) if venue.geocoded?
	end
end
