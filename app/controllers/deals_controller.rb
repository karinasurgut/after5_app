class DealsController < ApplicationController
  #before_action :admin_user, only: [:new, :edit, :create, :update, :destroy]

  def create
    @venue = Venue.find(deal_params[:venue_id])
    @deal = @venue.deals.build(deal_params)
    if @deal.save
      flash[:success] = "Deal created!"
      redirect_to venue_path(@venue)
    else
      @deal = []
      render 'venues/deal'
    end
  end

 def search  
    @deals= Deal.all
    @hash = Gmaps4rails.build_markers(@deals) do |deal, marker|
      marker.lat deal.venue.latitude
      marker.lng deal.venue.longitude
      marker.infowindow "<span class='glyphicon glyphicon-cutlery'></span>
      <p style='color:red;'>#{deal.title}</p><i>#{deal.venue.name}</i><p>#{deal.content}</p>"
    end  
end

  def destroy
    @venue = Venue.find(params[:id])
    @deal.destroy
    redirect_to venue_path(@venue)
  end

  def edit

  end

  def update
    if @deal.update_attributes(deal_params)
      flash[:success] = "Deal updated"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  private

    def deal_params
      params.require(:deal).permit(:content, :title, :venue_id)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end