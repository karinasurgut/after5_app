class DealsController < ApplicationController
  #before_action :admin_user, only: [:new, :edit, :create, :update, :destroy]

  def create
    @venue = Venue.find(deal_params[:venue_id])
    @deal = @venue.deals.build(deal_params)
    if @deal.save
      flash[:success] = "Deal created successfully!"
      redirect_to venue_path(@venue)
    else
      @deal = []
      render 'venues/deal'
    end
  end

 def search  
    @deals = Deal.search params[:search]
    # if params[:tag]
    #   @deals = Deal.tagged_with(params[:tag])
    # end
      #@deals= Deal.all
    # @hash = Gmaps4rails.build_markers(@deals) do |deal, marker|
    #   marker.lat deal.venue.latitude
    #   marker.lng deal.venue.longitude
    #   marker.infowindow "<span class='glyphicon glyphicon-cutlery'></span>
    #   <p style='color:red;'>#{deal.title}</p><i>#{deal.venue.name}</i><p>#{deal.content}</p>"
    # end  
end

  def destroy
    @venue = Venue.find(params[:id])
    @deal.destroy
    redirect_to venue_path(@venue)
  end

  def edit
    @deal = Deal.find(params[:id])
    @venue = @deal.venue
  end

  def update
    @deal = Deal.find(params[:id])
    if @deal.update_attributes(deal_params)
      flash[:success] = "Deal updated"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def upvote
    @deal = Deal.find(params[:id])
    @deal.upvote_by current_user
    redirect_to venue_path(@deal.venue)
  end

  def downvote
    @deal = Deal.find(params[:id])
    @deal.downvote_by current_user
    redirect_to venue_path(@deal.venue)
  end

  def want
    @deal = Deal.find(params[:id])
    @deal.liked_by current_user
    redirect_to venue_path(@deal.venue)
  end

  def checkin 
    @deal = Deal.find(params[:id])
    @checkin = Checkin.create!(deal: @deal, user: current_user)
    if @checkin.save
      flash[:success] = "Deal saved to your profile!"
      redirect_to venue_path(@deal.venue)
    else
      @checkin = []
      flash[:error] = "Something went wrong when checking in for the deal"
      redirect_to venue_path(@deal.venue)
    end
  end


  private

    def deal_params
      params.require(:deal).permit(:content, :title, :venue_id, :tag_list, :start_date, :end_date,
                                  checkins_attributes: [:deal_id, :user_id],
                                  durations_attributes: [:deal_id, :week_day, :from_time, :till_time, :all_day])
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end