class MicroController < ApplicationController

  layout 'micro_landing'

  include UsersHelper

  # need to use form helper to handle name (first name, last name), email submits
  # and track the request.referrer url.  Set virtual == true.
  def guidance 
    @page_title = "Guidance"
    @user = LeadUser.new
  end

  def tracking
    @page_title = "Tracking"
    @user = LeadUser.new
  end

  def social
    @page_title = "Social"
    @user = LeadUser.new
  end

  def save_lead 
    first_name = first_name lead_user_params[:name]
    last_name = last_name lead_user_params[:name]

    lead = LeadUser.new(first_name: first_name, last_name: last_name, email: lead_user_params[:email],
                  referrer: request.referrer)
    if lead.save
      flash[:success] = "Thank you for your interest.  You will be the first to be notified when we have exciting news from Family Bridge!" 
      redirect_to request.referrer 
    else
      flash[:danger] = "Email is not valid or you have already registered!"
      redirect_to request.referrer 
    end
  end

  # January 14, 2014 landing page test
  def tools_landing
    @page_title = "Tools for Elderly Care"
    @choice_layout = 1+rand(3)
  end

  def launching_soon
    @page_title = "Launching Soon"
  end

  def lead_saved 
    first_name = first_name lead_user_params[:name]
    last_name = last_name lead_user_params[:name]

    lead = LeadUser.new(first_name: first_name, last_name: last_name, email: lead_user_params[:email],
                  referrer: request.referrer)
    if lead.save
      flash[:success] = "Thank you for your interest.  You will be the first to be notified when we have exciting news from Family Bridge!" 
    else
      flash[:danger] = "Email is not valid or you have already registered!"
    end
  end

  private
    def lead_user_params
      params.permit(:name, :email)
    end
end
