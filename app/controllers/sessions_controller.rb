class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      if @user.email_confirmed
        log_in(@user)
        redirect_to root_path
      else
        flash.now[:error] = "Please follow the instructions in the account confirmation email you received in order to proceed."
        render 'new'
      end
    else
      flash.now[:error] = "Invalid email or password combination."
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

end
