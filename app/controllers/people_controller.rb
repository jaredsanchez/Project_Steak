class PeopleController < ApplicationController


  def index
    @people = Person.all
    sort = params[:sort] || session[:sort]
    order = params[:order] || session[:order]
    case sort
    when 'name'
      case order
      when 'asc'
        @people.sort! {|a,b| a.name<=> b.name}
      when 'desc'
        @people.sort! {|a,b| b.name<=>a.name}
      end
    when "progress"
      case order
      when 'asc'
	@people.sort! { |a,b| b.progress <=> a.progress}
      when 'desc'
        @people.sort! { |a,b| a.progress <=> b.progress}
      end
    end
  end


  def create
    @person = Person.create!(params[:person])
    flash[:notice] = "#{@person.name} was successfully added to your list of stake holders"
    redirect_to "/" and return
  end


  def update
    @person = Person.find params[:id]
    @person.update_attributes!(params[:person])
    flash[:notice] = "#{@person.name} was successfully updated."
    redirect_to people_path(@person)
  end


end
