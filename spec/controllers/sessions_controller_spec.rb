require 'spec_helper'

describe SessionsController do
  
  
  before do 
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:linkedin]
  end

  describe 'sign into linkedin' do
    it 'can sign a user into linkedin' do 
      visit '/people'
      page.should have_button("Find LinkedIn Connections")
      OmniAuth.config.add_mock(:linkedin, {:uid => '12345'})
      #mock_auth_hash
      click_button 'Find LinkedIn Connections'
      current_path.should eq(people_path)
     # page.should have_content('Signed in with LinkedIn')
    end
  
    it 'can handle authentication error' do
      visit '/people'
      page.should have_button("Find LinkedIn Connections")
      OmniAuth.config.mock_auth[:linkedin] = :invalid_credentials
      click_button 'Find LinkedIn Connections'
      current_path.should eq(root_path)
      #page.should have_content('Authentication error:')
    end
  end
end
   
