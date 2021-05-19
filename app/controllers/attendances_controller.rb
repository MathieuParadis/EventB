class AttendancesController < ApplicationController
  def index
    @event_id = params[:format]
    @event = Event.find(@event_id)
  
    @attendances = Attendance.where(event: @event)
  
  end

  def new
    @event_id = params[:format]
    @event = Event.find(@event_id) 
  end

  def create
    @event_id = params[:format]
    @event = Event.find(@event_id) 
    user = current_user

    @attendance = Attendance.new(event: @event, guest: user) 

    if @attendance.save 
      flash[:Notice] = "You enrolled succesfully"
      redirect_to @attendance
    else
      flash.now[:notice] = @attendance.errors.full_messages
      render :new
    end
  end
end

