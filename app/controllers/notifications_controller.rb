# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :move_to_signed_in, except: []

  def index
    @notifications = Notification.where(user_id: current_user.id, checked: false)
    @notifications.update(checked: true)
  end
end
