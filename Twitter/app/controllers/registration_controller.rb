class RegistrationController < Devise::RegistrationsController

  def new
  end

  def create
    if params[:name].strip == "" || params[:email].strip == "" || params[:mobile].strip == ""
      redirect_to new_user_registration_path
      return
    end
    @user = User.new
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]
    @user.password_confirmation =params[:password_confirmation]
    @user.valid?
    if @user.errors.blank?
      @user.save
      redirect_to new_user_session_path
      return
    end

    redirect_to new_user_registration_path

  end

end