class ConnectionController < ApplicationController
  before_filter :authenticate_user!

  def index
    @following_list=Connection.where(:follower_id => current_user.id)
    @follower_list=Connection.where(:following_id => current_user.id)
  end

  def create

    user=User.find_by_email params[:email]
    if user.nil?
      flash[:notice]="username not found!"
      redirect_to connection_index_path
      return
    end

    if params[:email] == current_user.email
      flash[:notice]="Cannot follow yourself!"
      redirect_to connection_index_path
      return
    end


    connection=Connection.find_by_following_id_and_follower_id  current_user.id, user.id
    if connection.nil?
      n=Notification.find_by_to_id_and_from_id_and_note_type(current_user.id, user.id, "request")
      if n.nil?
        redirect_to notification_index_path
        return
      end

      connection=Connection.new
      connection.follower=user
      connection.following=current_user
      connection.save

      n.from=current_user
      n.to=user
      n.note_type="accept"
      n.save
      redirect_to notification_index_path
      return
    end

    flash[:notice]="already a follower!"
    redirect_to connection_index_path

  end

  def update

    connection=Connection.find_by_following_id_and_follower_id params[:user_id], current_user.id
    connection.destroy
    redirect_to connection_index_path
  end

end
