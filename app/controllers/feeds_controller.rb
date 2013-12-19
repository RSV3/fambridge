class FeedsController < ApplicationController

  before_action :signed_in_user
  before_action :correct_user, only: :destroy

  def create
    @feed = current_user.feeds.build(feed_params)
    if @feed.save
      flash[:success] = "Your post has been submitted!"
      redirect_to root_url
    else
      @feed_items = []
      render 'main/home'
    end
  end

  def destroy
    @feed.destroy
    redirect_to root_url
  end

  private

    def feed_params
      params.require(:feed).permit(:content)
    end

    def correct_user
      @feed = current_user.feeds.find_by(id: params[:id])
      redirect_to root_url if @feed.nil?
    end
end