class ContentController < ApplicationController

  include ApplicationHelper

  def index
    # landing page for content for now
    @articles = Content.all
    @categories = Category.all
  end

  def show 
    # show particular article page
    c = Content.find_by_slug(params[:id])
    if c
      render "content/#{params[:category]}/#{c.slug}"
    else
      not_found
    end
  end

end
