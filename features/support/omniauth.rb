#Code taken from http://pivotallabs.com/testing-omniauth-based-login-via-cucumber/

Before('@omniauth-test') do 
	OmniAuth.config.test_mode = true
	user_information = Hash.new
	user_information["email"] = "test@xxxx.com"
	user_information["first_name"] = "Test"
	user_information["last_name"] = "User"
	user_information["name"] = "Test User"


	google_config = Hash.new
	google_config["provider"] = "google"
	google_config["uid"] = "http://xxxx.com/openid?id=118181138998978630963"
	google_config["user_information"] = user_information
	OmniAuth.config.mock_auth[:google] = google_config 
	
end

After('@omniauth-test') do 
	OmniAuth.config.test_mode = false
end