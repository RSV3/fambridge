class ContentController < ApplicationController

  include ApplicationHelper
  include UsersHelper

  def index
    # landing page defaults to elder-law content for now 
    default_slug = params[:slug]
    if !default_slug
      default_slug = "elder-law"
    end
    @articles = Content.where(homepage: true).order(:homepage_order)
    @tagline = "Caregiving Made Simple"

    @headline = Content.where(homepage_highlight: true)[0]
    @bottom = @articles[-1]
    @articles = @articles[0..-2]

    @recent_articles = ["Choosing the Right Care",
        "How to Pay for Care",
        "Legal Documents You Need"] 

    render :layout => "custom_application"
  end

  def subscribe

    if params.has_key?(:name)
      first_name = first_name lead_user_params[:name]
      last_name = last_name lead_user_params[:name]
    else
      first_name = lead_user_params[:email] 
      last_name = ""
    end

    lead = LeadUser.new(first_name: first_name, last_name: last_name, email: lead_user_params[:email],
                  referrer: request.referrer)
    if lead.save
      flash[:success] = "Thank you for your interest.  You will be the first to be notified when we have exciting news from Family Bridge!" 
    else
      flash[:danger] = "Email is not valid or you have already registered!"
    end
    redirect_to request.referrer

  end

  def show 
    @article = Content.find_by_slug(params[:id])

    @category_slug = @article.main_category.slug

    if @category_slug == "elder-law"
      @recent_articles = ["Guide to the Legal Documents You Need to Act on Your Parent’s Behalf",
          "Making Powers of Attorney, Advance Directives, & Wills",
          "Is a Trust Right for You?",
          "Estate Planning Basics"]
      @tagline = "Legal issues simplified for caregivers and their families"
    elsif @category_slug == "financial-matters"
      @recent_articles = ["Understanding the Costs of Care",
          "How to Pay for Care",
          "What does Medicare/Medicaid Cover?",
          "Where to find benefits and other savings"] 
      @tagline = "Financial matters simplified for caregivers and their families"
    elsif @category_slug == "care-decisions"
      @recent_articles = ["What are the different types of care?",
          "Tips for Choosing the Right Care",
          "How to Age at Home",
          "Communication Basics"] 
      @tagline = "Care Decisions simplified for caregivers and their families"
    else
      @recent_articles = nil
      @tagline = "Caregiver stories and comic relief!"
    end

    if request.get?
      # show particular article page
      if @article 
        render "content/#{params[:category]}/#{@article.slug}", :layout => "content_article"
      else
        not_found
      end
    end
  end

  def category
    # show articles in a particular category
    @category_slug = params[:slug]
    @articles = Content.joins(:main_category).where(categories: {slug: @category_slug})

    if @category_slug == "elder-law"
      @recent_articles = ["Guide to the Legal Documents You Need to Act on Your Parent’s Behalf",
          "Making Powers of Attorney, Advance Directives, & Wills",
          "Is a Trust Right for You?",
          "Estate Planning Basics"]
      @tagline = "Legal issues simplified for caregivers and their families"
    elsif @category_slug == "financial-matters"
      @recent_articles = ["Understanding the Costs of Care",
          "How to Pay for Care",
          "What does Medicare/Medicaid Cover?",
          "Where to find benefits and other savings"] 
      @tagline = "Financial matters simplified for caregivers and their families"
    elsif @category_slug == "care-decisions"
      @recent_articles = ["What are the different types of care?",
          "Tips for Choosing the Right Care",
          "How to Age at Home",
          "Communication Basics"] 
      @tagline = "Care Decisions simplified for caregivers and their families"
    else
      @recent_articles = nil
      @tagline = "Caregiver stories and comic relief!"
    end


    @category = Category.find_by_slug(@category_slug)
    render :layout => "custom_application"
  end

  private
    def lead_user_params
      params.permit(:name, :email)
    end
end
