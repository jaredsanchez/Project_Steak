class PeopleController < ApplicationController


  def index
    @people = Person.all
  end


  def create
    @person = Person.create!(params[:person])
    flash[:notice] = "#{@person.name} was successfully added to your list of stake holders"
    redirect_to people_path and return
  end


end
