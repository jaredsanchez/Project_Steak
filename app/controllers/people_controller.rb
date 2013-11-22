class PeopleController < ApplicationController

  before_filter :init_vars

  def init_vars
    @favorites = Person.find(:all, :conditions => { :favorite => true})
  end
  def new
  end

  def index
    @people = Person.all.sort! {|a,b| a.last_name <=> b.last_name}
    sort = params[:sort] || session[:sort]
    order = params[:order] || session[:order]
    case sort
    when "progress"
      case order
      when 'asc'
        @people.sort! do |a, b| 
          if (b.send(sort) == a.send(sort))
            a.first_name <=> b.first_name
          else
            a.send(sort) <=> b.send(sort)
          end
        end
      when 'desc'
        @people.sort! do |a, b| 
          if (a.send(sort) == b.send(sort))
            a.first_name <=> b.first_name
          else
            b.send(sort) <=> a.send(sort)
          end
        end
      end
    else
      case order
      when 'asc'
        @people.sort! {|a,b| 
	  if a.send(sort) == b.send(sort)
	    a.last_name <=> b.last_name
	  else
	    a.send(sort)<=> b.send(sort)
	  end
	}
      when 'desc'
        @people.sort! {|a,b| 
	  if b.send(sort) == a.send(sort)
	    a.last_name <=> b.last_name
	  else
	    b.send(sort)<=> a.send(sort)
	  end
	}
      end
    end
  end

  def show
    @person = Person.find params[:id] 
  end

  def create
    @person = Person.new params[:person]
    if @person.save
      flash[:notice] = "#{@person.first_name} was successfully added to your list of stake holders"
      redirect_to person_path(@person)
    else
      render :new
    end
  end

  def edit
    @person = Person.find params[:id]
  end

  def update
    @person = Person.find params[:id]
    @person.update_attributes!(params[:person])
    flash[:notice] = "#{@person.name} was successfully updated."
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy
    flash[:notice] = "'#{@person.first_name}' deleted."
    redirect_to people_path
  end

end
