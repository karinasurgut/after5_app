class VenuesController < ApplicationController
  #before_action :admin_user, only: [:new, :edit, :create, :update, :destroy]
  before_action :get_venue, except: [:index, :create, :new, :destroy]
  def new
  	@venue = Venue.new
  end
  
  def index
   @venues = Venue.all
  end

  def deal 
    @deal = @venue.deals.build
  end

  def show
    @deals = @venue.deals
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
  end

  def update  	
  	if @venue.update_attributes(venue_params)
      flash[:success] = "Venue updated"
      redirect_to @venue
    else
      render 'edit'
    end
  end

  def destroy
  	Venue.find(params[:id]).destroy
    flash[:success] = "Venue deleted."
    redirect_to root_url
  end

  private
  	def venue_params
  		params.require(:venue).permit(:name, :email, :street, :suburb, :postcode, :region, :state, :country,
  									  :website, :phone, :latitude, :longitude)
  	end
  	
  	def get_venue
      @venue = Venue.where(id: params[:id]).first
      redirect_to(root_url) if @venue.nil?
  	end

    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
