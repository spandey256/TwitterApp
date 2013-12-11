class ProfileController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  def index
    @user=User.find params[:user_id]

  end


  def create
    if params[:name].strip==""
      @status="Please fill the form correctly!"
      render :action => "new"
      return
    end
    @user = current_user
    @user.name = params[:name]
    @user.email = params[:email]
    @user.mobile = params[:mobile]
    @user.password = params[:password]
    @user.password_confirmation =params[:password_confirmation]
    @user.valid?
    if @user.errors.blank?
      @user.save
      redirect_to profile_index_path
      return
    end
    @status="Please fill the form correctly!"
    render :action => "new"

  end


end
