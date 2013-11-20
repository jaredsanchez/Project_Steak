class EventsController < ApplicationController
  require 'google/api_client'
  require 'client_builder'

  def index
    @events = Event.all
    @people = Person.all
    # if (user_signed_in? )
    #   client = ClientBuilder.get_client(current_user)
    #   service = client.discovered_api('calendar', 'v3')
    #   result = client.execute(:api_method => service.calendar_list.list)
    #   @calendars = result.data
    #   @calendar_data = Hash.new
    #   @calendars.items.each { |cal|
    #     event = client.execute(:api_method => service.events.list, :parameters => {'calendarId'=> cal.id})
    #     cal_events = event.data.items
    #     cal_events.each { |curr_event|
    #       if !cal.summary.nil? 
    #         if !@calendar_data[cal.summary].nil?
    #           @calendar_data[cal.summary] << curr_event["summary"] 
    #           @calendar_data[cal.summary] << curr_event["id"]
    #         else 
    #           @calendar_data[cal.summary]  = Array.new
    #           @calendar_data[cal.summary] << curr_event["summary"]
    #           @calendar_data[cal.summary] << curr_event["id"]
    #         end
    #       end 
    #     }
    #   }
    #end
  end

  def update
    puts "update called"
    if (user_signed_in? )
      client = ClientBuilder.get_client(current_user)
      service = client.discovered_api('calendar', 'v3')
      result = client.execute(:api_method => service.calendar_list.list)
      calendars = result.data
      google_cal_hash = Hash.new
      calendars.items.each { |cal|
        event = client.execute(:api_method => service.events.list, :parameters => {'calendarId'=> cal.id})
        cal_events = event.data.items
        cal_events.each { |curr_event|
          if !curr_event["id"].nil?
            google_cal_hash[curr_event["id"]] = curr_event
          end
        } 
      }
      google_cal_hash.each {|google_id, event| 
        if Event.find_by_google_id(google_id).nil?
          Event.create!(:name => event["summary"], :google_id => google_id, :where => event["location"], :event_time => event["start"]["dateTime"])
        end
      }
    end
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
