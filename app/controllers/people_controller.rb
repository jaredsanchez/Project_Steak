class PeopleController < ApplicationController
  
  @people = Person.all

  def new
    @people = Person.all
  end

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

  def show
    @people = Person.all
    @person = Person.find params[:id] 
  end

  def create
    @people = Person.all
    @person = Person.new params[:person]

    if @person.save
      flash[:notice] = "#{@person.name} was successfully added to your list of stake holders"
      redirect_to person_path(@person)
    else
      render :new
    end
  end

  def edit
    @people = Person.all
    @person = Person.find params[:id]
    @person.update_attributes!(params[:person])
    flash[:notice] = "#{@person.name} was successfully updated."
  end

  def destroy
    @people = Person.all
    @person = Person.find(params[:id])
    @person.destroy
    flash[:notice] = "'#{@person.name}' deleted."
    redirect_to people_path
  end

end
