class ContentController < ApplicationController

  def index
    # landing page for content for now
  end

  def show 
    # show particular article page
    c = Content.find(params[:id])
    @article_url = c.url 
  end

end
