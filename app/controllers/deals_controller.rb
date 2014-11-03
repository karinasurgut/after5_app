class DealsController < ApplicationController
  before_action :admin_user, only: [:new, :edit, :create, :update, :destroy]
  before_action :signed_in, only: [ :checkin, :upvote, :downvote, :want ]
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
  
  def show
    @deal = Deal.find(params[:id])
  end

  def search
    if cookies[:lat_lng]
      @lat = cookies[:lat_lng].split("|")[0]
      @lng = cookies[:lat_lng].split("|")[1]
    else
      @lat = -33.873651
      @lng = 151.2068896
    end
    @deals = Deal.search params[:search],  :star => true, :populate => true, :geo => [@lat,@lng],
    :order => "geodist ASC", :page => params[:page], :per_page => 5
    if params[:tag]
      @deals = Deal.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
    end
    #@deals= Deal.paginate(page: params[:page], per_page: 5)
    @hash = Gmaps4rails.build_markers(@deals) do |deal, marker|
      marker.lat deal.venue.latitude
      marker.lng deal.venue.longitude
      marker.title "#{deal.venue.name}"
      marker.infowindow "<span class='glyphicon glyphicon-cutlery'></span>
      <p style='color:red;'>#{deal.title}</p><i>#{deal.venue.name}</i><p>#{deal.content}</p>"
      # marker.picture({
      #    :url => "assets/pin3.png",
      #    :width  => "32",
      #    :height => "32"
      # })
    end
    @hash += Gmaps4rails.build_markers(current_user) do |user, marker|
      marker.lat @lat
      marker.lng @lng
      marker.infowindow "<span class='glyphicon glyphicon-user'></span>
      <p style='color:red;'>This is you!</p>"
      marker.picture({
         :url => "assets/pin.png",
         :width  => "32",
         :height => "32"
      })
    end  
end

  def destroy
    @deal = Deal.find(params[:id])
    @venue = @deal.venue
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
    session[:return_to] ||= request.referer
    flash[:success] = "You liked the deal!"
     respond_to do |format|
      format.js
      format.html { redirect_to session.delete(:return_to) } #redirect_to venue_path(@deal.venue) }
    end
  end

  def downvote
    @deal = Deal.find(params[:id])
    @deal.downvote_by current_user
    session[:return_to] ||= request.referer
     flash[:success] = "Thank you for your feedback!"
     respond_to do |format|
      format.js
      format.html { redirect_to session.delete(:return_to) }#redirect_to venue_path(@deal.venue) }
    end
  end

  def want
    @deal = Deal.find(params[:id])
    @deal.liked_by current_user
    respond_to do |format|
      format.js
      #format.html { venue_path(@deal.venue) }
    end
  end

  def checkin 
    @deal = Deal.find(params[:id])
    @checkin = Checkin.create!(deal: @deal, user: current_user)
    if @checkin.save
      flash[:success] = "Deal saved to your profile!"
    else
      @checkin = []
      flash[:error] = "Something went wrong when checking in for the deal"
    end
    respond_to do |format|
      format.js
      format.html { redirect_to venue_path(@deal.venue) }
    end
    
  end

  private

    def deal_params
      params.require(:deal).permit(:content, :title, :venue_id, :tag_list, :start_date, :end_date, :day,
                                  checkins_attributes: [:deal_id, :user_id],
                                  durations_attributes: [:deal_id, :week_day, :from_time, :till_time, :all_day])
    end

    def admin_user
      redirect_to(root_url) unless (user_signed_in? && current_user.id == 2)
    end

    def signed_in
      
      unless user_signed_in?
        session[:return_to] ||= request.referer
        flash[:notice] = "Please log in for more action!"
        redirect_to session.delete(:return_to)
      end
    end

end