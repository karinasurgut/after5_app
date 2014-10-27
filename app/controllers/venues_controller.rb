class VenuesController < ApplicationController
  #before_action :admin_user, only: [:new, :edit, :create, :update, :destroy]
  before_action :get_venue, except: [:index, :create, :new, :destroy]
  def new
  	@venue = Venue.new
    days = [1,2,3,4,5,6,0]
    days.each do |d|
     @venue.hours.build(day: d)
    end
  end
  
  def index
   if params[:tag]
      @venues = Venue.tagged_with(params[:tag])
    else
      @venues= Venue.all
    end  
  end

  def deal 
    @deal = @venue.deals.build
    days = [1,2,3,4,5,6,0]
    days.each do |d|
     @duration = @deal.durations.build(week_day:d)
    end

  end

  def show
    @deals = @venue.deals
    @hours = @venue.hours.all
  end
  
  def create
  	@venue = Venue.new(venue_params)
    if @venue.save
      flash[:success] = "Venue has been added!"
      redirect_to @venue
    else
      render 'new'
    end
  end

  def edit
    #@hours = @venue.hours.find(params[:id])
  end

  def update  	
  	#allhours = @venue.hours.all #find(params[:id])
    #allhours.each do |h|
      #@venue.hours.find_by(id: params[:id])
      if @venue.update_attributes(venue_params)
        flash[:success] = "Venue updated"
        redirect_to @venue
      else
        render 'edit'
      end
    #end
  end

  def destroy
  	Venue.find(params[:id]).destroy
    flash[:success] = "Venue deleted."
    redirect_to root_url
  end

  private
  	def venue_params
  		params.require(:venue).permit(:name, :email, :image, :street, :suburb, 
                                    :postcode, :region, :state, :country,
  									               :website, :phone, :latitude, :longitude, :tag_list,
                                   hours_attributes: [:id, :venue_id, :day, :open_time, :close_time, :closed])
  	end

  	def get_venue
      @venue = Venue.where(id: params[:id]).first
      redirect_to(root_url) if @venue.nil?
  	end

    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
