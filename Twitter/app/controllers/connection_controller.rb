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


    connection=Connection.find_by_following_id_and_follower_id user.id, current_user.id
    if connection.nil?

      connection=Connection.new
      connection.follower=current_user
      connection.following=user
      connection.save
      redirect_to connection_index_path
      return
    end

    flash[:notice]="already following!"
    redirect_to connection_index_path

  end

  def update

    connection=Connection.find_by_following_id_and_follower_id params[:user_id], current_user.id
    connection.destroy
    redirect_to connection_index_path
  end

end
