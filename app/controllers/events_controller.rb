class EventsController < ApplicationController
  require 'google/api_client'
  require 'client_builder'

  before_filter :init_vars

  def init_vars
    @favorites = Person.find(:all, :conditions => { :favorite => true})
  end

  def refresh
    if (user_signed_in? )
      client = ClientBuilder.get_client(current_user)
      service = client.discovered_api('calendar', 'v3')
      result = client.execute(:api_method => service.calendar_list.list)

      calendars = result.data
      google_cal_hash = Hash.new
      calendars.items.each { |cal|
        if (cal.summary == "CS169 Project")

          session[:calendar_id] = cal.id
          event = client.execute(:api_method => service.events.list, :parameters => {'calendarId'=> cal.id})
          cal_events = event.data.items
          cal_events.each { |curr_event|
            if !curr_event["id"].nil?
              google_cal_hash[curr_event["id"]] = curr_event
            end
          } 
        end
      }
      google_cal_hash.each {|google_id, value| 
        puts value["summary"]
        if Event.find_by_google_id(google_id).nil?
          newevent = Event.create!(:name => value["summary"], :google_id => google_id, :where => value["location"], :event_time => value["start"]["dateTime"], :description => value["description"], :uid => current_user.uid)
          puts "newevent"
          puts newevent
        end
      }
    end
    redirect_to events_path and return
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
        if order == 'desc'
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
      flash[:notice] = "#{person.first_name} was added to this event"
      redirect_to event_path(@event)
    end
  end

  def destroy
    event = Event.find(params[:id])
    client = ClientBuilder.get_client(current_user)
    service = client.discovered_api('calendar', 'v3')
    result = client.execute(:api_method => service.events.delete, :parameters => {'calendarId' => session[:calendar_id], 'eventId' => event.google_id})
    event.destroy
    flash[:notice]= "#{event.name} Deleted"
    redirect_to events_path  and return
  end

  def show
    @event = Event.find params[:id] 
  end

  def calendar
    render :calendar
  end

  def create
    @event = Event.new params[:event]
    @event.uid = current_user.uid
    if @event.save
    #should eventually include attendees with email
      attendees = [{"email" => "bob@gmail.com"}]
      event = {
        'summary' => @event.name,
        'location' => @event.where,
        'start' => {'dateTime' => @event.event_time.to_datetime.rfc3339},
        'end' => {'dateTime' => @event.event_time.to_datetime.rfc3339},
        'attendees' => attendees
      }
      client = ClientBuilder.get_client(current_user)
      service = client.discovered_api('calendar', 'v3')

      result = client.execute(:api_method => service.events.insert, :parameters => {'calendarId' => session[:calendar_id]}, :body => JSON.dump(event),   :headers => {'Content-Type' => 'application/json'})
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

end
