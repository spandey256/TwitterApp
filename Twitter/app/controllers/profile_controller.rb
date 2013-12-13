class ProfileController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  def index
    begin
      @user=User.find params[:user_id]
    rescue ActiveRecord::RecordNotFound
      @user=nil
    end
  end
end
