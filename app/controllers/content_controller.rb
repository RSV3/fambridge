class ContentController < ApplicationController

  include ApplicationHelper

  def index
    # landing page defaults to elder-law content for now 
    default_slug = params[:slug]
    if default_slug
      @articles = Content.includes(:categories).where(categories: { slug: default_slug })
    else
      @articles = Content.includes(:categories).where(categories: { slug: "elder-law" })
    end
    @highlight = @articles[-1]
    @articles = @articles[0..-2]

    @recent_articles = Content.where(recent: true)
  end

  def show 
    # show particular article page
    c = Content.find_by_slug(params[:id])
    if c
      render "content/#{params[:category]}/#{c.slug}", :layout => "content_article"
    else
      not_found
    end
  end

  def category
    # show articles in a particular category
    @articles = Content.includes(:categories).where(categories: { slug: params[:slug] })
    @highlight = @articles[-1]
    @articles = @articles[0..-2]

    @recent_articles = Content.where(recent: true)
  end

  def recent
    # show articles ordered by recency
    @articles = Content.order(created_at: :desc )
  end
end
