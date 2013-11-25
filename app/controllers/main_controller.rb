class MainController < ApplicationController
  def index
    @favorites = Person.find(:all, :conditions => { :favorite => true})
    @people = Person.find(:all, :order => 'name')
    if user_signed_in?
        render 'index'
    else
        #redirect_to signin_path
	render 'index'
    end
  end
end
