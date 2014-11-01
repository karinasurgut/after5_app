class StaticPagesController < ApplicationController
  def home
  	unless params[:day].nil?
  	@day = Date.parse(params[:day])
  	else
  	@day = Date.today
    end
  	@feed = Deal.deal_carousel(@day)
  end

  def about
  end

  def contact
  end

  def terms
  end

  def from_carousel
    @day1 = Date.parse(params[:day])
    @feed1 = Deal.deal_carousel(@day1)
    respond_to do |format|
      format.js
      #format.html { redirect_to root_path }
    end
  end

end
