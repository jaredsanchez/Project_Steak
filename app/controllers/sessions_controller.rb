class SessionsController < ApplicationController

  def new
    #puts "New gets called"
    redirect_to '/auth/google_oauth2'
  end

  def create
    auth = request.env["omniauth.auth"]
    user = User.where(:provider => auth['provider'],
                      :uid => auth['uid']).first || User.create_with_omniauth(auth)
    user.token = auth[:credentials][:token];
    user.token_expires_at = Time.at(auth[:credentials][:expires_at])
    user.refresh_token = auth[:credentials][:refresh_token]
    user.save

    session[:user_id] = user.id
    redirect_to events_path, :notice => 'Signed in!'
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

end
