class MainController < ApplicationController
  def index
    @favorites = Person.find(:all, :conditions => { :favorite => true})
    @people = Person.find(:all, :order => 'name')
    render 'index'
  end
end
