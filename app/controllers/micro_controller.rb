class MicroController < ApplicationController

  def guidance 
    @page_title = "Guidance"
  end

  def tracking
    @page_title = "Tracking"
  end

  def social
    @page_title = "Social"
  end

end
