class UsersController < ApplicationController

  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

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

  private

    def user_params
      params.require(:user).permit(:first_name, :email, :password,
                                  :password_confirmation, :profile_photo,
                                  :send_weekly_report, :agree_terms)
    end

    def signed_in_user
      redirect_to signin_url, warning: "Please sign in first to access the page." unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
