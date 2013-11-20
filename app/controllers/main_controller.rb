class MainController < ApplicationController
  def index
    if user_signed_in?
        @people = Person.all 
        render 'index'
    else
        #redirect_to signin_path
        @people = Person.all 
        render 'index'
    end
  end
end
