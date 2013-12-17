class UsersController < ApplicationController

  before_action :signed_in_user, only: [:edit, :update, :destroy, :family]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:index, :destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def family
    # show users who are same family members
    @users = [current_user] 
  end

  # signup_path
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # handle successful user save
      sign_in @user
      flash[:success] = "Your account has been created successfully. Welcome to Family Bridge!"
      redirect_to @user
    else
      flash[:danger] = "Your account failed to be created."
      render 'new'
    end
  end

  # public view of the user
  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Your profile has been successfully updated."
      redirect_to @user
    else
      flash.now[:danger] = "Enter valid values"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :email, :password,
                                  :password_confirmation, :profile_photo,
                                  :send_weekly_report, :agree_terms)
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, flash: { warning: "Please sign in first to access the page." }
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url, flash: { warning: "You are not authorized." }) unless current_user && current_user.super_admin?
    end

end
