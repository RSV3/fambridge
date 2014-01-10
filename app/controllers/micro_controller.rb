class MicroController < ApplicationController

  def guidance 
    @page_title = "Guidance"
    @user = User.new
  end

  def tracking
    @page_title = "Tracking"
    @user = User.new
  end

  def social
    @page_title = "Social"
    @user = User.new
  end

end
