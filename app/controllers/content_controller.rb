class ContentController < ApplicationController

  include ApplicationHelper
  include UsersHelper

  def index
    @page_title = "Caregiving Made Simple"
    # landing page defaults to elder-law content for now 
    default_slug = params[:slug]
    if !default_slug
      default_slug = "elder-law"
    end
    @articles = Content.where(homepage: true).order(:homepage_order)

    @headline = Content.where(homepage_highlight: true)[0]
    #@bottom_articles = @articles[4..-1]
    #@articles = @articles[0..3]
    @bottom_articles = []

    # to log subscriber on segment.io, customer.io
    if session.has_key?(:lead_id)
      @subscriber = LeadUser.find_by_id(session[:lead_id])
      session.delete(:lead_id)
    end

    render :layout => "custom_application"
  end

  def popup_closed
    session[:email_submitted] = true
  end

  def subscribe
    if !lead_user_params[:email].empty?
      @first_name = first_name lead_user_params[:name]
      @last_name = last_name lead_user_params[:name]

      lead = LeadUser.new(first_name: @first_name, last_name: @last_name, 
                    email: lead_user_params[:email],
                    referrer: request.referrer)
      if lead.save
        flash[:success] = "Thank you for your interest.  You will be the first to be notified when we have exciting news from Family Bridge!"
        # so that popup email form does not popup again
        session[:lead_id] = lead.id
        session[:email_submitted] = true
      else
        lead = LeadUser.find_by_email(lead_user_params[:email])
        if lead.nil?
          flash[:danger] = "Email is not valid please resubscribe." 
        else
          flash[:danger] = "You seem to have already registered!"
          # so that popup email form does not popup again
          session[:lead_id] = lead.id       
          session[:email_submitted] = true
        end
      end
    else
      flash[:danger] = "Email is not valid please resubscribe."
    end
    redirect_to request.referrer
  end

  def popup_subscribe
    if !lead_user_params[:email].empty?
      @first_name = first_name lead_user_params[:name]
      @last_name = last_name lead_user_params[:name]
      @zipcode = lead_user_params[:zipcode]

      lead = LeadUser.new(first_name: @first_name, last_name: @last_name, 
                    email: lead_user_params[:email],
                    zipcode: lead_user_params[:zipcode],
                    referrer: request.referrer)
      if lead.save
        flash[:success] = "Thank you for your interest.  You will be the first to be notified when we have exciting news from Family Bridge!"
        # so that popup email form does not popup again
        session[:lead_id] = lead.id
        session[:email_submitted] = true
      else
        lead = LeadUser.find_by_email(lead_user_params[:email])
        if lead.nil?
          flash[:danger] = "Email is not valid please resubscribe." 
        else
          flash[:danger] = "You seem to have already registered!"
          # so that popup email form does not popup again
          session[:lead_id] = lead.id       
          session[:email_submitted] = true
        end
      end
    else
      flash[:danger] = "Email is not valid please resubscribe."
    end

    redirect_to request.referrer
  end

  def show 
    @article = Content.find_by_slug(params[:id])
    @category_slug = @article.main_category.slug

    ids_to_exclude = [@article.id]
    @related_articles = Content.joins(:main_category).where(categories: {slug: @category_slug}).where.not(id: ids_to_exclude).limit(3)

    if @category_slug == "elder-law"
      @tagline = "Legal issues simplified for caregivers and their families"
    elsif @category_slug == "financial-matters"
      @tagline = "Financial matters simplified for caregivers and their families"
    elsif @category_slug == "care-decisions"
      @tagline = "Care Decisions simplified for caregivers and their families"
    else
      @tagline = "Caregiver stories and comic relief!"
    end

    # to log subscriber on segment.io, customer.io
    if session.has_key?(:lead_id)
      @subscriber = LeadUser.find_by_id(session[:lead_id])
      session.delete(:lead_id)
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
      @tagline = "Legal issues simplified for caregivers and their families"
      @page_title = "Elder Law"
    elsif @category_slug == "financial-matters"
      @tagline = "Financial matters simplified for caregivers and their families"
      @page_title = "Financial Matters"
    elsif @category_slug == "care-decisions"
      @tagline = "Care Decisions simplified for caregivers and their families"
      @page_title = "Care Decisions"
    else
      @tagline = "Caregiver stories and comic relief!"
      @page_title = "Caregiver Blog"
    end

    # to log subscriber on segment.io, customer.io
    if session.has_key?(:lead_id)
      @subscriber = LeadUser.find_by_id(session[:lead_id])
      session.delete(:lead_id)
    end

    @category = Category.find_by_slug(@category_slug)
    render :layout => "custom_application"
  end

  def about
    @page_title = "About Us"
    @tagline = "Caregiving Made Simple"

    render :layout => "custom_application"
  end

  private
    def lead_user_params
      params.permit(:name, :email, :zipcode)
    end
end
