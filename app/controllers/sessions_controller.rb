class SessionsController < ApplicationController
  require 'nokogiri'
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
    temp_client = LinkedIn::Client.new(ENV['LINKEDIN_KEY'],ENV['LINKEDIN_SECRET'])
    # fix so ACCESSS_TOKEN and ACCESS_SECRET don't need to be hard coded in
    temp_client.authorize_from_access('ACCESSS_TOKEN', 'ACCESS_SECRET')
    xml_doc = Nokogiri::XML(temp_client.connections.to_xml)
    first_names = xml_doc.xpath('//first-name')
    last_names = xml_doc.xpath('//last-name')
    connections = first_names.zip(last_names)
    connections.each do |connection|
      first_name = connection[0].text
      last_name = connection[1].text
      full_name = first_name + ' ' + last_name
      match = Person.find_by_name(full_name)
      if match
        match.is_linkedin_connection = true
      end
    end
    redirect_to people_path and return
    
    #client = OAuth2::Client.new(
     #       ENV['LINKEDIN_KEY']ENV['LINKEDIN_KEY'],
      #              :site => "https://www.linkedin.com",
       #             :token_url => "/uas/oauth2/accessToken",
        #            :authorize_url => "/uas/oauth2/authorization?resopse_type=code")
    #token = auth['credentials']['token']

  end
end
