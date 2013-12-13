class NotificationController < ApplicationController
  before_filter :authenticate_user!
  def index
    @notes= Notification.order("updated_at DESC").find_all_by_to_id current_user.id
  end

  def create
    user=User.find_by_email params[:email]

    if user.nil?
      flash[:notice]="username not found!"
      redirect_to connection_index_path
      return
    end

    if params[:type]=="request"
      if params[:email] == current_user.email
        flash[:notice]="Cannot follow yourself!"
        redirect_to connection_index_path
        return
      end
      c=Connection.find_by_following_id_and_follower_id(user.id, current_user.id)
      if !c.nil?
        flash[:notice]="Already Following!"
        redirect_to connection_index_path
        return
      end
      n=Notification.create! to: user, from: current_user, note_type: "request"

      flash[:notice]="Request sent!"
      redirect_to connection_index_path
    elsif params[:type]=="Decline"
      n=Notification.find_by_to_id_and_from_id(current_user.id,user.id)
      if n.nil?
        redirect_to notification_index_path
        return
      end

      n.to=user
      n.from=current_user
      n.note_type="decline"
      n.save
    end
    redirect_to notification_index_path
  end

end