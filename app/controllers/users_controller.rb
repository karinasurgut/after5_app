class UsersController < ApplicationController
  before_action :correct_user, only: [:edit,:update, :wishlist, :visited, :checkins]
  #before_action :authenticate_user!, only: [:edit,:update]

  def new
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    # For Rails 4
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

    # required for settings form to submit when password is left blank
    if account_update_params[:password].blank?
      account_update_params.delete("password")
      account_update_params.delete("password_confirmation")
    end

    @user = User.find(params[:id])
    if @user.update_attributes(account_update_params)
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  def user_location
    @lat_lng = cookies[:lat_lng].split("|")
  end

  def wishlist
  end

  def visited
  end

  def checkins
    @checkin_items = current_user.checkins_list
  end

  def interests
    @user = User.find(params[:id])
  end

  def create_interests
    @user = User.find(params[:id])
    @user.interest_list = params[:interest_list]
    @user.save
  end

  def update_interests
    @user = User.find(params[:id])
    #if @user.update_attributes(user_params)
    interests = ""
    params[:interest_list].each do |k,v|
      interests += v.join(', ')
    end
    if @user.update_attributes(interest_list: interests)
        flash[:success] = "Interests updated!"
        redirect_to @user
      else
        render 'interests'
      end
  end

  private
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :phone, 
                                   :location, :interest_list, 
                                   :password_confirmation)
  	end

    # Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end

end
