class EventsController < ApplicationController

  def index
    @favorites = Person.find(:all, :conditions => { :favorite => true})
    @events = Event.all
    sort = params[:sort] || session[:sort]
    order = params[:order] || session[:order]
    case sort
    when 'name'
      case order
      when 'asc'
        @events.sort! {|a,b| a.name<=> b.name}
      when 'desc'
        @events.sort! {|a,b| b.name<=>a.name}
      end
    end
  end

  def new 
    @favorites = Person.find(:all, :conditions => { :favorite => true})
  end
  
  def add_person
    @favorites = Person.find(:all, :conditions => { :favorite => true})
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
    @favorites = Person.find(:all, :conditions => { :favorite => true})
    event = Event.find(params[:id])
    event.destroy
    flash[:notice]= "#{event.name}   Deleted"
    redirect_to events_path  and return
  end

  def show
    @favorites = Person.find(:all, :conditions => { :favorite => true})
    @events = Event.all
    @event = Event.find params[:id] 
    redirect_to event_path(@event)
  end

  def create
    @event = Event.new params[:event]
    @favorites = Person.find(:all, :conditions => { :favorite => true})
    if @event.save
      flash[:notice] = "#{@event.name} was successfully added to your list of events"
      redirect_to event_path(@event)
    else
      @event = Event.all
      render :new
    end
  end

  def edit
    @favorites = Person.find(:all, :conditions => { :favorite => true})
    @event = Event.find(params[:id])
  end


  def update
    @favorites = Person.find(:all, :conditions => { :favorite => true})
    @event = Event.find(params[:id])
    @event.update_attributes!(params[:event])
    flash[:notice] = "#{@event.name} was successfully updated."
    redirect_to event_path(@event)
  end
end
