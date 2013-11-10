class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def create
    @event = Event.create!(params[:event])
    flash[:notice] = "#{@event.name} was successfully added"
    redirect_to people_path and return
  end

  def edit
    @event = Event.find(params[:id])
  end
end
