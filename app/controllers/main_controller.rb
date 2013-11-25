class MainController < ApplicationController
  def index
<<<<<<< HEAD
    @favorites = Person.find(:all, :conditions => { :favorite => true})
    @people = Person.find(:all, :order => 'name')
    render 'index'
=======
    if user_signed_in?
        @favorites = Person.find(:all, :conditions => { :favorite => true})
        @people = Person.all 
        render 'index'
    else
        #redirect_to signin_path
        @favorites = Person.find(:all, :conditions => { :favorite => true})
        @people = Person.all 
        render 'index'
    end
>>>>>>> acf78c2e4734a05faeabbd6ec8641254aeaf0e35
  end
end
