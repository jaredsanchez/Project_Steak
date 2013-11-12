class EventsController < ApplicationController

  def index
    @events = Event.all
    @people = Person.all
  end

  def new 
    @people = Person.all
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
    @people = Person.all
    event = Event.find(params[:id])
    event.destroy
    flash[:notice]= "#{event.name}   Deleted"
    redirect_to events_path  and return
  end

  def show
    id = params[:id]
    @people = Person.all
    @event = Event.find_by_id(id)


  end
  def create
    @people = Person.all
    @event = Event.create!(params[:event])
    flash[:notice] = "#{@event.name} was successfully added"
    redirect_to "/events" and return
  end

  def edit
    @people = Person.all
    @event = Event.find(params[:id])
  end


  def update
    @event = Event.find(params[:id])
    @event.update_attributes!(params[:event])
    flash[:notice] = "#{@event.name} was successfully updated."
    redirect_to event_path(@event)
  end
end
