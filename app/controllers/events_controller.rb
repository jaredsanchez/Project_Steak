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
        if Event.find_by_google_id(google_id).nil?
          newevent = Event.create!(:name => value["summary"], :google_id => google_id, :where => value["location"], :event_time => value["start"]["dateTime"], :description => value["description"], :uid => current_user.uid)
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
    person = Person.find_by_id params[:person][:person_id]
    if person == nil
      redirect_to event_path(@event)
    elsif @event.people.include? person
      flash[:notice] = "#{person.first_name} was already added to this event"
      redirect_to event_path(@event)
    else
      @event.people << person
      @event.save!
      flash[:notice] = "#{person.first_name} was added to this event"
      redirect_to event_path(@event)
    end
  end

  def add_group
    @event = Event.find(params[:id])
    group = Group.find_by_id params[:group][:group_id]
    if group == nil
      redirect_to event_path(@event)
    else
      group.people.each { |person|
        if ! @event.people.include? person
          @event.people << person
        end
      }
      @event.save!
      flash[:notice] = "#{group.name} was added to this event"
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
    if user_signed_in?
      client = ClientBuilder.get_client(current_user)
      service = client.discovered_api('calendar', 'v3')
      result = client.execute(:api_method => service.calendar_list.list)

      calendars = result.data
      google_cal_hash = Hash.new
      calendars.items.each { |cal|
        if (cal.summary == "CS169 Project") 
          session[:calendar_id] = cal.id
        end
      }
    end
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
      if ! result.data.nil?
        return_event = result.data
        @event.google_id = return_event.id
        @event.save
      end
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

  def send_invites
    @event = Event.find(params[:id])
    if (user_signed_in? )
      client = ClientBuilder.get_client(current_user)
      service = client.discovered_api('calendar', 'v3')
      result = client.execute(:api_method => service.events.get,
                              :parameters => {'calendarId' => session[:calendar_id], 'eventId' => @event.google_id})
      gevent = result.data
      email_list = [] 
      @event.people.each { | person|
        if person.email
          email_list << {'email' => person.email}
        end
      }
      gevent.attendees = email_list
      result = client.execute(:api_method => service.events.update,
                              :parameters => {'calendarId' => session[:calendar_id], 
                                              'eventId' => gevent.id,
                                              'sendNotifications' => true}, 
                              :body_object => gevent,
                              :headers => {'Content-Type' => 'application/json'})
      if result
        flash[:notice] = "Emails sent!"
      end
    end
    redirect_to event_path(@event)
  end

end
