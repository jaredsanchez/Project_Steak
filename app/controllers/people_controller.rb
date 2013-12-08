class PeopleController < ApplicationController

  before_filter :init_vars

  def init_vars
    @favorites = Person.find(:all, :conditions => { :favorite => true})
  end

  def new
  end

  def index  
    sort = params[:sort] || session[:sort]
    order = params[:order] || session[:order]
    search_terms = params[:search_term]

    safe_sort_params = ['first_name', 'last_name', 
	'progress', 'email', 'hr_dept_name', 
	'cal_net_dept_name', 'building', 
	'room_number', 'phone_number',
        'job_title']

    if search_terms
      @people = Person.search(search_terms)
    else
      @people = Person.all
    end 

    if safe_sort_params.include? sort
      @people.sort! { |a,b|
        r1 = a.send(sort)
        r2 = b.send(sort)
        if r1 == r2
          a.last_name <=> b.last_name
        elsif order == 'desc'
	  r2<=>r1
        else
          r1<=>r2
        end
      }    
    else
      @people.sort! {|a,b| a.last_name <=> b.last_name}
    end
  end

  def show
    @person = Person.find params[:id] 
  end

  def create
    @person = Person.new params[:person]
    if @person.save
      flash[:notice] = "#{@person.first_name} was successfully added to your list of stakeholders"
      redirect_to person_path(@person)
    else
      render :new
    end
  end

  def edit
    @person = Person.find params[:id]
  end

  def update
      @person = Person.find(params[:id])
      if @person.update_attributes(params[:person])
         flash[:notice] = "#{@person.first_name} was successfully updated."
         redirect_to person_path(@person)
      else
         render :edit
      end
  end

  def destroy
    person = Person.find(params[:id])
    person.destroy
    flash[:notice] = "#{person.first_name} deleted."
    redirect_to people_path and return
  end

end
