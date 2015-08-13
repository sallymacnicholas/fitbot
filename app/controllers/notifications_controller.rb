class NotificationsController < ApplicationController
  def index
    @notification = Notification.new
  end

  def new
  end

  def show
    @notification = Notification.new
  end

  def create
    @notification = Notification.create(note_params)
    @notification.user_id = current_user.id
    @notification.save
    redirect_to profile_path(current_user)
    NotificationMessage.new.welcome(current_user)
  end

  private

  def note_params
    params.require(:notification).permit(:number)
  end
end
