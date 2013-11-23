class SessionsController < ApplicationController
  require 'nokogiri'
  require 'client_builder'
  require 'linkedin'

  def new
    #puts "New gets called"
    redirect_to '/auth/google_oauth2'
  end

  def create
    auth = request.env["omniauth.auth"]
    if auth['provider'] == 'linkedin'
      find_linkedin_connections(auth)
    else
      user = User.where(:provider => auth['provider'],
                      :uid => auth['uid']).first || User.create_with_omniauth(auth)
      user.token = auth[:credentials][:token];
      user.token_expires_at = Time.at(auth[:credentials][:expires_at])
      user.refresh_token = auth[:credentials][:refresh_token]
      user.save

      session[:user_id] = user.id
      redirect_to events_path, :notice => 'Signed in!'
    end
  end

  def destroy
    #reset_session
    session[:user_id] = nil
    redirect_to events_path, :notice => 'Signed out!'
  end

  def failure
    # if you want to debug something better, this is the object you want
    #auth = request.env["omniauth.error"]
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

  def new_linkedin
    redirect_to '/auth/linkedin'
  end

  def find_linkedin_connections(auth)
    #temp_user = User.create_with_omniauth(auth)
    #temp_user.token = auth[:credentials][:token]
    #temp_client = LinkedIn::Client.new
    #temp_client.authorize_from_access(auth[:credentials][:token], auth[:credentials][:secret])
    #connections = temp_client.connections
    client = OAuth2::Client.new(
            ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET'],
                    :site => "https://www.linkedin.com",
                    :token_url => "/uas/oauth2/accessToken",
                    :authorize_url => "/uas/oauth2/authorization?resopse_type=code")
    connections = client.connections

    #xml_doc = Nokogiri::XML(auth['info']['connections'])
    #first_names = xml_doc.xpath('//first-name')
    #last_names = xml_doc.xpath('//last-name')
    #connections = first_names.zip(last_names)
    #connections.each do |connection|
      #connection.text
      #redirect_to events_path and return
    #end
    #redirect_to people_path and return
  end
end
