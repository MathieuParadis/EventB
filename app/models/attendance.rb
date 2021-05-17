class Attendance < ApplicationRecord
  # after_create :report_admin_send

  belongs_to :guest, class_name: "User"
  belongs_to :event

  def report_admin_send
    AdminMailer.admin_report_email(self.event.admin).deliver_now
  end

end
