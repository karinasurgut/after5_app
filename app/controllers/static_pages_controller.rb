class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def contact
  end

  def terms
  end

  def search

    @venues = Venues.all
    @hash = Gmaps4rails.build_markers(@venues) do |venue, marker|
      marker.lat venue.latitude
      marker.lng venue.longitude
    end
  end
end
