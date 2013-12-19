class MainController < ApplicationController

  before_action :signed_in_user, only: [:home]

  def home
    @user = current_user
    if signed_in?
      @feed = current_user.feeds.build
      @feed_items = current_user.feeds.paginate(page: params[:page])
    end
  end

  def index
    if current_user
      redirect_to home_path
    end
  end

  def about
    @page_title = "About Us"
  end

  def privacy
    @page_title = "Privacy Policy"
  end

  def terms
    @page_title = "Terms"
  end

  def contact
    @page_title = "Contact"
  end

  def help
    @page_title = "Help"
  end

  def tour
    @page_title = "Take a Tour"
  end
end
