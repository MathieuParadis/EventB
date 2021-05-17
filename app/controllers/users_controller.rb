class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user_id = params[:id]
    @users = User.all

    @user = @users.find(@user_id)
    p @events_admin = Event.where(admin: @user)

    unless current_user == @user
      flash[:danger] = "Action impossible"
      redirect_to :root
    end
  end
  
  def edit
    @user = User.find(params[:id])

    unless current_user == @user
      flash[:danger] = "Action impossible"
      redirect_to :root
    end
  end

  def update
    @user = User.find(params[:id])

    unless current_user == @user
      flash[:danger] = "Action impossible"
      redirect_to @user
    end

    if @user.update(first_name: params[:user_first_name], last_name: params[:user_last_name], description: params[:user_description])
      flash[:Notice] = "Information modified successfully"
      redirect_to @user
    else
      flash.now[:notice] = @user.errors.full_messages
      render :edit
    end
  end




end
