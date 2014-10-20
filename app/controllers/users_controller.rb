class UsersController < ApplicationController
  before_action :correct_user, only: [:edit,:update]
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

  private
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :phone, :location, 
  									:password_confirmation)
  	end

    # Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
