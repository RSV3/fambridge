class UsersController < ApplicationController

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

  private

    def user_params
      params.require(:user).permit(:first_name, :email, :password,
                                  :password_confirmation, :profile_photo,
                                  :send_weekly_report, :agree_terms)
    end

end
