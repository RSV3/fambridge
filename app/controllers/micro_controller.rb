class MicroController < ApplicationController

  layout 'micro_landing'

  include UsersHelper

  def guidance
    # deprecated 
    @page_title = "Guidance"
    @user = LeadUser.new
  end

  def tracking
    # deprecated 
    @page_title = "Tracking"
    @user = LeadUser.new
  end

  def social
    # deprecated 
    @page_title = "Social"
    @user = LeadUser.new
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

  def guide_download
    @page_title = "Guide Download Page"
    # download a report
    @access = params[:access]

    if request.post?
      if !lead_user_params[:email].empty?
        session[:download_access] = params[:access] 
        @first_name = first_name lead_user_params[:name]
        @last_name = last_name lead_user_params[:name]
        @zipcode = lead_user_params[:zipcode]

        @lead_user = LeadUser.new(first_name: @first_name, last_name: @last_name, 
                      email: lead_user_params[:email],
                      zipcode: lead_user_params[:zipcode],
                      referrer: request.referrer)
        if @lead_user.save
          flash.now[:success] = "You can now download the guide.  You will also be the first to be notified when we have exciting news from Family Bridge!" 
        else
          @lead_user = LeadUser.find_by_email(lead_user_params[:email])
          flash.now[:danger] = "You seem to have already registered!  You can now download the guide."
        end
      else
        flash[:danger] = "Email is not valid or you have already registered!"
        redirect_to tax_guide_landing_path
      end
    else
      # handle get request
      if session[:download_access]
        send_file "#{Rails.root}/app/assets/images/content/legal-guide.pdf" 
        session.delete(:download_access)
      else
        flash.now[:danger] = "You need to first submit your contact information to download the guide."
      end
    end
  end

  def tax_guide_landing
    # elder law guide landing
    @page_title = "Your Guide to Elderly Care Law"

    # provide an access code to URL so that it cannot be accessed by anybody
    require 'securerandom'
    @access = SecureRandom.hex(32)
  end

  private
    def lead_user_params
      params.permit(:name, :email, :zipcode)
    end
end
