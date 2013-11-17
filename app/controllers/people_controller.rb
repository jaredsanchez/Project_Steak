class PeopleController < ApplicationController

  def new
    @favorites = Person.find(:all, :conditions => { :favorite => true})
  end

  def index
    @people = Person.all.sort! {|a,b| a.first_name<=> b.first_name}
    @favorites = Person.find(:all, :conditions => { :favorite => true})
    sort = params[:sort] || session[:sort]
    order = params[:order] || session[:order]
    case sort
    when 'last_name'
      case order
      when 'asc'
        @people.sort! {|a,b| a.last_name<=> b.last_name}
      when 'desc'
        @people.sort! {|a,b| b.last_name<=>a.last_name}
      end
    when 'first_name'
      case order
      when 'asc'
        @people.sort! {|a,b| a.first_name<=> b.first_name}
      when 'desc'
        @people.sort! {|a,b| b.first_name<=>a.first_name}
      end
    when "progress"
      case order
      when 'asc'
	@people.sort! { |a,b| b.progress <=> a.progress}
      when 'desc'
        @people.sort! { |a,b| a.progress <=> b.progress}
      end
    when 'favorite'
      case order
      when 'asc'
        @people.sort! do |a, b| 
          if (a.favorite == b.favorite)
            a.first_name <=> b.first_name
          elsif a.favorite
            1
          else
            -1
          end
        end
      when 'desc'
         @people.sort! do |a, b| 
          if (b.favorite == a.favorite)
            a.first_name <=> b.first_name
          elsif b.favorite
            1
          else
            -1
          end
        end
      end
    end
  end

  def show
    @favorites = Person.find(:all, :conditions => { :favorite => true})
    @person = Person.find params[:id] 
  end

  def create
    @person = Person.new params[:person]
    @favorites = Person.find(:all, :conditions => { :favorite => true})
    if @person.save
      flash[:notice] = "#{@person.first_name} was successfully added to your list of stake holders"
      redirect_to person_path(@person)
    else
      render :new
    end
  end

  def edit
    @favorites = Person.find(:all, :conditions => { :favorite => true})
    @person = Person.find params[:id]
    @person.update_attributes!(params[:person])
    flash[:notice] = "#{@person.name} was successfully updated."
  end

  def destroy
    @favorites = Person.find(:all, :conditions => { :favorite => true})
    @person = Person.find(params[:id])
    @person.destroy
    flash[:notice] = "'#{@person.first_name}' deleted."
    redirect_to people_path
  end

end
