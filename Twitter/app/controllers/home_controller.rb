class HomeController < ApplicationController
    before_filter :authenticate_user!


  def index
    if params[:page].nil?
      @page=1
    else
      @page=Integer(params[:page])
    end
    @tweet_list= UserTweet.order("created_at DESC").paginate(:page => params[:page],:per_page => 10)
    @page+=1

  end


  def create
    if params[:tweet].strip==""
      @status="Blank tweet cannot be posted..."
      @page=1
      @tweet_list= UserTweet.order("created_at DESC").paginate(:page => params[:page],:per_page => 10)
      @page+=1
      render :action => "index"
      return
    end
    @status="Tweet successfully posted!"
    UserTweet.create(tweet: params[:tweet], user: current_user)
    redirect_to home_index_path


  end
end
