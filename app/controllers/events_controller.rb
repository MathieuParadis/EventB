class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = Event.all
    @events = @events.sort_by {|event| event.start_date}

  end

  def show
    @event_id = params[:id]
    @events = Event.all

    @event = @events.find(@event_id)
    @guests_event = Attendance.where(event: @event)

  end

  def new
  end

  def create
    puts params

    user = current_user

    @event = Event.new(title: params[:event_title], start_date: params[:event_start_date], duration:params[:event_duration],
                       description: params[:event_description], price: params[:event_price], location: params[:event_location],
                       admin: user) 

    if @event.save 
      flash[:Notice] = "Event successfully created"
      redirect_to @event
    else
      flash.now[:notice] = @event.errors.full_messages
      render :new
    end
  end




end
