class AttendancesController < ApplicationController
  def index
    @event_id = params[:event_id]
    @event = Event.find(@event_id)
  
    @attendances = Attendance.where(event: @event)
  
  end

  def new
    @event_id = params[:event_id]
    @event = Event.find(@event_id) 
  end

  def create
    # Before the rescue, at the beginning of the method
    @stripe_amount = 500

    @event_id = params[:event_id]
    @event = Event.find(@event_id) 
    user = current_user

    begin
      
      customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
      })

      charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @stripe_amount,
      description: "Achat d'un produit",
      currency: 'eur',
      })

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to @attendance
    end

    @attendance = Attendance.new(event: @event, guest: user, stripe_customer_id: customer.id) 


    if @attendance.save 
      flash[:Notice] = "You enrolled succesfully"
      redirect_to @event
    else
      flash.now[:notice] = @attendance.errors.full_messages
      render :new
    end


  end



end

