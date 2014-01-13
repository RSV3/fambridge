class MicroController < ApplicationController

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

  def guidance_save
    first_name = first_name lead_user_params[:name]
    last_name = last_name lead_user_params[:name]

    lead = LeadUser.new(first_name: first_name, last_name: last_name, email: lead_user_params[:email],
                  referrer: request.referrer)
    if lead.save
      flash[:success] = "Thank you for your interest.  You will be the first to be notified when we have exciting news from Family Bridge!" 
      redirect_to request.referrer 
    else
      flash[:danger] = "Email is not valid!"
      redirect_to request.referrer 
    end
  end

  def tracking_save
    first_name = first_name lead_user_params[:name]
    last_name = last_name lead_user_params[:name]

    lead = LeadUser.new(first_name: first_name, last_name: last_name, email: lead_user_params[:email],
                  referrer: request.referrer)
    if lead.save
      flash[:success] = "Thank you for your interest.  You will be the first to be notified when we have exciting news from Family Bridge!" 
      redirect_to request.referrer 
    else
      flash[:danger] = "Email is not valid!"
      redirect_to request.referrer 
    end
  end

  def social_save
    first_name = first_name lead_user_params[:name]
    last_name = last_name lead_user_params[:name]

    lead = LeadUser.new(first_name: first_name, last_name: last_name, email: lead_user_params[:email],
                  referrer: request.referrer)
    if lead.save
      flash[:success] = "Thank you for your interest.  You will be the first to be notified when we have exciting news from Family Bridge!" 
      redirect_to request.referrer 
    else
      flash[:danger] = "Email is not valid!"
      redirect_to request.referrer 
    end
  end

  private
    def lead_user_params
      params.permit(:name, :email)
    end
end
