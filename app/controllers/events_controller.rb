class EventsController < ApplicationController

  before_filter :init_vars

  def init_vars
    @favorites = Person.find(:all, :conditions => { :favorite => true})
  end


  def index
    @events = Event.all
    sort = params[:sort] || session[:sort]
    order = params[:order] || session[:order]
    if sort == 'name'
      case order
      when 'asc'
        @events.sort! {|a,b| a.send(sort)<=> b.send(sort)}
      when 'desc'
        @events.sort! {|a,b| b.send(sort)<=>a.send(sort)}
      end
    end
  end

  def new 
  end
  
  def add_person
    @event = Event.find(params[:id])
    person = Person.find_by_name(params[:name_person])
    if person == nil
      flash[:warning] = "Could not find person with name #{params[:name_person]}"
      redirect_to event_path(@event) and return
    else
      @event.people << person
      @event.save!
      flash[:notice] = "#{person.name} was added to this event"
      redirect_to event_path(@event) and return
    end
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    flash[:notice]= "#{event.name}   Deleted"
    redirect_to events_path  and return
  end

  def show
    @events = Event.all
    @event = Event.find params[:id] 
    redirect_to event_path(@event)
  end

  def create
    @event = Event.new params[:event]
    if @event.save
      flash[:notice] = "#{@event.name} was successfully added to your list of events"
      redirect_to event_path(@event)
    else
      @event = Event.all
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
end
