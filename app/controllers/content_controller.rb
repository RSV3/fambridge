class ContentController < ApplicationController

  include ApplicationHelper
  include UsersHelper

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

    render :layout => "custom_application"
  end

  def show 
    @article = Content.find_by_slug(params[:id])
    @category_slug = @article.categories[0].slug
    @recent_articles = Content.where(recent: true)

    if request.get?
      # show particular article page
      if @article 
        render "content/#{params[:category]}/#{@article.slug}", :layout => "content_article"
      else
        not_found
      end
    elsif request.post?
      first_name = first_name lead_user_params[:name]
      last_name = last_name lead_user_params[:name]

      lead = LeadUser.new(first_name: first_name, last_name: last_name, email: lead_user_params[:email],
                    referrer: request.referrer)
      if lead.save
        flash.now[:success] = "Thank you for your interest.  You will be the first to be notified when we have exciting news from Family Bridge!" 
      else
        flash.now[:danger] = "Email is not valid or you have already registered!"
      end
      render "content/#{params[:category]}/#{@article.slug}", :layout => "content_article"
    end
  end

  def category
    # show articles in a particular category
    @articles = Content.includes(:categories).where(categories: { slug: params[:slug] })
    @highlight = @articles[-1]
    @articles = @articles[0..-2]

    @recent_articles = Content.where(recent: true)
    @category = Category.find_by_slug(params[:slug])
    render :layout => "custom_application"
  end

  def recent
    # show articles ordered by recency
    @articles = Content.order(created_at: :desc )
  end

  private
    def lead_user_params
      params.permit(:name, :email)
    end
end
