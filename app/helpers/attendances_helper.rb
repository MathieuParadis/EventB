module AttendancesHelper
  def is_user_attending?
    event = Event.find(params[:id])
    user = current_user

    Attendance.where(event: event, guest: user).count != 0 ? true : false
  end



end
