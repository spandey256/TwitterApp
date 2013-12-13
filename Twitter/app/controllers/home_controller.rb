class HomeController < ApplicationController
    before_filter :authenticate_user!


  def index
    if params[:page].nil?
      @page=1
    else
      @page=Integer(params[:page])
    end
    connection=Connection.find_all_by_follower_id current_user.id
    search=[]
    connection.each do|c|
      search.append c.following_id
    end
    search.append current_user.id
    @tweet_list= UserTweet.where(:user_id => search).order("created_at DESC").paginate(:page => params[:page],:per_page => 10)

  end


  def create
    if params[:tweet].strip==""
      flash[:status]="Blank tweet cannot be posted..."
      redirect_to home_index_path
      return
    end
    flash[:status]="Tweet successfully posted!"
    UserTweet.create(tweet: params[:tweet], user: current_user)

    redirect_to home_index_path


  end
end
