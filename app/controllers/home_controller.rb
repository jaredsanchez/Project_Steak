class HomeController < ApplicationController
  require 'google/api_client'
  require 'client_builder'
  def index
    if (user_signed_in? )
      client = ClientBuilder.get_client(current_user)
      service = client.discovered_api('calendar', 'v3')
      result = client.execute(:api_method => service.calendar_list.list)

      puts "Calendars"
      @calendar_events = Hash.new
      @calendars.items.each { |cal|
        event = client.execute(:api_method => service.events.list, :parameters => {'calendarId'=> cal.id})
        puts "events got got for calendar: " + cal.summary
        cal_events = event.data.items

        #if calendar_events[cal.id].nil?
        #  calendar_events[cal.id] = Hash.new
        #end

        cal_events.each { |curr_event|
          #puts curr_event.inspect

          #puts "Event name: " 
          #puts curr_event["displayName"]
          #if ! curr_event.nil? 
            #calendar_events[curr_event["summary"]]  = curr_event
          #  calendar_events[calendarId][curr_event]
          #end

          puts "Event Summary: "
          puts curr_event["summary"]
          puts "Starts at : " 
          puts curr_event["start"]
          puts "Ends at : " 
          puts curr_event["end"]
          puts "Event location: "
          puts curr_event["location"]
        }


        #@calendar_events[cal.summary] = client.execute(:api_method => service.events.list, cal.id)

        #puts cal.summary
        #puts cal.description
        #puts cal.id
      }

      @calendars = result.data
    end

  end
end