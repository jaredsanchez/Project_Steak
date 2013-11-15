class MainController < ApplicationController
  def index
    @people = Person.find(:all, :order => 'name')
    render 'index'
  end
end
