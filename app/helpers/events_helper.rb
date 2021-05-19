module EventsHelper
  def is_user_admin?
    event = Event.find(params[:id])
    user = current_user

    event.admin == user ? true : false
  end
end