class NotificationsController < ApplicationController
  def index
    @notification = Notification.new
  end

  def new
  end

  def create
    @notification = Notification.create(note_params)
    @notification.user_id = current_user.id
    @notification.save
    redirect_to notifications_path
    NotificationMessage.new.welcome(current_user)
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    redirect_to notifications_path
  end

  private

  def note_params
    params.require(:notification).permit(:number)
  end
end
