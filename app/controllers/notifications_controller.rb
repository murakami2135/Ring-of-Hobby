class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(user_id: current_user.id, checked: false)
    @notifications.update(checked: true)
  end
end
