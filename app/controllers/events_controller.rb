class EventsController < ApplicationController

  before_filter :init_vars

  def init_vars
    @favorites = Person.find(:all, :conditions => { :favorite => true})
  end

  def new 
  end

  def index
    sort = params[:sort] || session[:sort]
    order = params[:order] || session[:order]
    known_params = ['name']
    if known_params.include? sort
      @events = Event.all.sort! { |a,b|
        r1 = a.send(sort)
        r2 = b.send(sort)
        if order == 'asc'
	  r1<=>r2
        elsif order == 'desc'
	  r2<=>r1
        else
          r1<=>r2
        end
      }    
    else
      @events = Event.all.sort! {|a,b| a.name <=> b.name}
    end
  end

  def add_person
    @event = Event.find(params[:id])
    person = Person.find_by_name(params[:name_person])
    if person == nil
      flash[:warning] = "Could not find person with name #{params[:name_person]}"
      redirect_to event_path(@event)
    else
      @event.people << person
      @event.save!
      flash[:notice] = "#{person.name} was added to this event"
      redirect_to event_path(@event)
    end
  end

  def show
    @event = Event.find params[:id] 
  end

  def create
    @event = Event.new params[:event]
    if @event.save
      flash[:notice] = "#{@event.name} was successfully added to your list of events"
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end


  def update
    @event = Event.find(params[:id])
    @event.update_attributes!(params[:event])
    flash[:notice] = "#{@event.name} was successfully updated."
    redirect_to event_path(@event)
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    flash[:notice]= "#{event.name}   Deleted"
    redirect_to events_path and return
  end

end
